import 'package:bitsports/features/home/models/custom_people_model.dart';
import 'package:bitsports/features/home/models/planet_model.dart';
import 'package:bitsports/features/home/models/specie_model.dart';
import 'package:bitsports/features/home/models/vehicle_model.dart';
import 'package:bitsports/features/home/repositories/starwars_repository.dart';
import 'package:bitsports/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PeopleService with ChangeNotifier {
  final StarWarsRepository _repo;
  final http.Client _http;
  PeopleService(this._repo, this._http) {
    getPeople();
  }

  final List<CustomPeopleModel> _peoples = [];
  List<CustomPeopleModel> get peoples => _peoples;
  bool isLoading = false;
  bool isLoadingAll = false;

  // late Either<List<PeopleModel>, String> _result;
  String _error = '';
  String get error => _error;

  final String _firstPage = MyConfig.firstUrl;
  String get firstPage => _firstPage;

  String _actualPage = '';
  String get actualPage => _actualPage;

  String _previusPage = '';
  String get previusPage => _previusPage;

  String _nextPage = '';
  String get nextPage => _nextPage;

  final Map<String, SpecieModel> _species = {};
  final Map<String, PlanetModel> _planets = {};
  final Map<String, VehicleModel> _vehicles = {};
  final List<String> _personVechicles = [];
  List<String> get personVechicles => _personVechicles;

  final bool _isLoadingVehicles = false;
  bool get isLoadingVehicles => _isLoadingVehicles;

  setPage(String page) {
    _actualPage = page;
  }

  void setPeople(List<dynamic> data) async {
    // List<PeopleModel> people = [];
    for (var item in data) {
      CustomPeopleModel person = CustomPeopleModel.fromMap(item);
      _peoples.add(person);
      // notifyListeners();
    }

    // return people;
  }

  Future<void> getPeople({String page = ''}) async {
    _error = '';
    // print('init:getPeople');
    isLoadingAll = false;
    isLoading = true;
    final String newPage = (page == '') ? _firstPage : page;
    notifyListeners();

    var result = await _repo.getPeople(page: newPage, http: _http);

    result.fold((l) {
      setPeople(l.results);
      _previusPage = l.previous ?? '';
      _nextPage = l.next ?? '';
    }, (r) {
      // print('fold::error =>' + r);
      _error = r;
    });

    // print(_error);

    isLoading = false;
    isLoadingAll = true;

    notifyListeners();

    // print('getPeople::_peoples.length =>' + _peoples.length.toString());
    // print('getPeople::error =>' + _error);
    // print('end:getPeople');
  }

  Future<void> refreshData() async {
    // print('refreshData::After::_peoples => ' + _peoples.length.toString());
    _peoples.clear();
    // print('refreshData::Before::_peoples => ' + _peoples.length.toString());
    getPeople();
  }

  Future<void> getMorePeople() async {
    // print('getMorePeople::_nextPage =>' + _nextPage);

    if (_nextPage != '' && isLoadingAll && !isLoading) {
      isLoadingAll = false;
      notifyListeners();
      getPeople(page: _nextPage);
    } else {
      if (_nextPage == '') {
        _error = 'End of Data';
        isLoadingAll = true;
        notifyListeners();
      }
    }
  }

  Future<String> getSpecies(List<String> speciesUrl) async {
    String rta = '';
    if (speciesUrl.isEmpty) {
      rta = 'Human'; //if array is empty the specie is Human
    } else {
      if (_planets[speciesUrl] == null) {
        // if url not exits on species map, we need get from api
        var result = await _repo.getSpecies(http: _http, page: speciesUrl[0]);
        result.fold((l) {
          rta = l.name;
          _species[speciesUrl[0]] = l;
        }, (r) {
          rta = 'Unknown'; // if error put Unknown
        });
      } else {
        //if url exists in the map we take this
        rta = _planets[speciesUrl]!.name;
      }
    }
    return rta;
  }

  Future<String> getPlanet(String planetUrl) async {
    String rta = '';
    print('getPlanet => ' + planetUrl);
    if (planetUrl.isEmpty) {
      // if planet url sis empty the planet is Unknown
      rta = 'Unknown';
    } else {
      if (_planets[planetUrl] == null) {
        // if url not exits on planets map, we need get from api
        var result = await _repo.getPlanet(http: _http, page: planetUrl);
        result.fold((l) {
          rta = l.name;
          _planets[planetUrl] = l;
        }, (r) {
          rta = 'Unknown'; // if error the planet is Unknow
        });
      } else {
        //if url exists in the map we take this
        rta = _planets[planetUrl]!.name;
      }
    }
    return rta;
  }

  Future<List<String>> getVehicles({required CustomPeopleModel person}) async {
    // print('getVehicles::init');
    List<String> rta = [];

    for (var ele in person.vehicles) {
      if (_vehicles[ele] != null) {
        // print('no null');
        rta.add(_vehicles[ele]!.name);
      } else {
        // print('getVehicle');

        var result = await _repo.getVehicle(http: _http, page: ele);
        result.fold((l) {
          _vehicles[ele] = l;
          rta.add(_vehicles[ele]!.name);
        }, (r) {
          rta.add('Unknown');
        });
      }
    }

    // print('getVehicles::rta.length => ' + rta.length.toString());

    // print('getVehicles::end');

    return rta;
  }

  Future<String> getPersonSubtitle({required CustomPeopleModel person}) async {
    String rta = '';
    rta = await getSpecies(person.species);
    rta += ' from ';
    rta += await getPlanet(person.homeworld);
    return rta;
  }
}
