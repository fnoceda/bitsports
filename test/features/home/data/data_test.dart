import 'dart:convert';
import 'dart:io';
import 'package:bitsports/features/home/models/custom_people_model.dart';
import 'package:bitsports/features/home/models/planet_model.dart';
import 'package:bitsports/features/home/models/specie_model.dart';
import 'package:bitsports/features/home/models/vehicle_model.dart';
import 'package:dartz/dartz.dart';
import 'package:bitsports/features/home/data/starwars_data.dart';
import 'package:bitsports/features/home/repositories/starwars_repository.dart';
import 'package:bitsports/models/response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert' as convert;

class MocStarWarsRepository extends Mock implements StarWarsRepository {
  Future<Either<List<CustomPeopleModel>, String>> getPeopleData(
      {bool makeError = false, required String filePath}) async {
    String error = 'Some String';
    List<CustomPeopleModel> people = [];
    ResponseModel response = await getFileData(filePath);
    List<dynamic> data = response.data['results'];

    for (var item in data) {
      people.add(CustomPeopleModel.fromMap(item));
    }

    if (makeError) {
      return Right(error);
    } else {
      return Left(people);
    }
  }

  Future<Either<SpecieModel, String>> getSpeciesData(
      {bool makeError = false, required String filePath}) async {
    String error = 'Some String';
    late SpecieModel species;

    ResponseModel response = await getFileData(filePath);
    if (response.data != null) {
      species = SpecieModel.fromMap(response.data);
    } else {
      makeError = true;
      error = 'File dont work';
    }

    if (makeError) {
      return Right(error);
    } else {
      return Left(species);
    }
  }

  Future<Either<VehicleModel, String>> getVehicleData(
      {bool makeError = false, required String filePath}) async {
    String error = 'Some String';
    late VehicleModel data;

    ResponseModel response = await getFileData(filePath);
    if (response.data != null) {
      data = VehicleModel.fromMap(response.data);
    } else {
      makeError = true;
      error = 'File dont work';
    }

    if (makeError) {
      return Right(error);
    } else {
      return Left(data);
    }
  }

  Future<Either<PlanetModel, String>> getPlanetData(
      {bool makeError = false, required String filePath}) async {
    String error = 'Some String';
    late PlanetModel data;

    ResponseModel response = await getFileData(filePath);
    if (response.data != null) {
      data = PlanetModel.fromMap(response.data);
    } else {
      makeError = true;
      error = 'File dont work';
    }

    if (makeError) {
      return Right(error);
    } else {
      return Left(data);
    }
  }

  MockClient getMokClient({required filePath, int errorCode = 200}) {
    final mockHTTPClient = MockClient((request) async {
      final content = await File(filePath).readAsString();
      return Response(content, errorCode);
    });

    return mockHTTPClient;
  }

  Future<ResponseModel> getFileData(String filePath) async {
    late ResponseModel response;

    if (File(filePath).existsSync()) {
      final fileContents = await File(filePath)
          .readAsString(); //await rootBundle.loadString(filePath);
      final decodedJson = convert.jsonDecode(fileContents);

      response = ResponseModel(success: true, message: 'OK', data: decodedJson);
    } else {
      // print('MocStarWarsRepository:: [$filePath] does not exist');
      response =
          ResponseModel(success: false, message: 'File not found', data: null);
    }
    return response;
  }
}

void main() {
  late StarWarsRepository peopleService;
  late MocStarWarsRepository mocPeopleService;
  // late List<CustomPeopleModel> peoples;
  setUp(() {
    TestWidgetsFlutterBinding
        .ensureInitialized(); // <--this is necesary for read json files
    peopleService = StarWarsData();
    mocPeopleService = MocStarWarsRepository();
  });

  group("data success test", () {
    test("get people http success test", () async {
      List<CustomPeopleModel> peoples = [];
      List<CustomPeopleModel> matcherPeoples = [];
      String error = '';
      String matcherError = '';
      String filePath = 'test/features/home/data/people_data.json';
      final matcher = await mocPeopleService.getPeopleData(filePath: filePath);

      matcher.fold((l) {
        matcherPeoples.addAll(l);
      }, (r) {
        matcherError = r;
      });
      final result = await peopleService.getPeople(
          page: filePath,
          http: mocPeopleService.getMokClient(filePath: filePath));

      result.fold((l) {
        // peoples.addAll(l);
        List<dynamic> data = l.results;
        for (var item in data) {
          //print(item);
          peoples.add(CustomPeopleModel.fromMap(item));
        }
      }, (r) {
        error = 'error';
      });

      expect(peoples, matcherPeoples);
      expect(error, isEmpty);
      expect(matcherError, error);
    });
    test("get people http timeout test", () async {
      List<CustomPeopleModel> peoples = [];
      String error = '';
      const filePath = 'test/features/home/data/people_data.json';

      final result = await peopleService.getPeople(
        page: filePath,
        http: mocPeopleService.getMokClient(
          filePath: filePath,
          errorCode: 408, // send the timeout code for test that
        ),
      );

      result.fold((l) {
        List<dynamic> data = l.results;
        for (var item in data) {
          peoples.add(CustomPeopleModel.fromMap(item));
        }
      }, (r) {
        error = r;
      });

      // print('error =>' + error);

      expect(error, 'Failed to Load Data');
      expect(peoples, isEmpty);
    });

    test("get species http success test", () async {
      const filePath = 'test/features/home/data/species_data.json';
      late SpecieModel species;
      late SpecieModel matcherData;
      String error = '';
      String matcherError = '';

      final matcher = await mocPeopleService.getSpeciesData(filePath: filePath);
      matcher.fold((l) {
        matcherData = l;
      }, (r) {
        matcherError = r;
      });
      final result = await peopleService.getSpecies(
          page: filePath,
          http: mocPeopleService.getMokClient(filePath: filePath));

      result.fold((l) {
        species = l;
      }, (r) {
        error = 'error';
      });

      expect(species, matcherData);
      expect(error, isEmpty);
      expect(matcherError, error);
    });

    test("get species http timeout test", () async {
      late SpecieModel species;
      String error = '';
      const filePath = 'test/features/home/data/species_data.json';

      final result = await peopleService.getSpecies(
        page: filePath,
        http: mocPeopleService.getMokClient(
          filePath: filePath,
          errorCode: 408, // send the timeout code for test that
        ),
      );

      result.fold((l) {
        species = l;
      }, (r) {
        error = r;
      });

      expect(error, 'Unknow');
    });

    test("get vehicle http success test", () async {
      const filePath = 'test/features/home/data/vehicle_data.json';
      late VehicleModel vehicle;
      late VehicleModel matcherData;
      String error = '';
      String matcherError = '';

      final matcher = await mocPeopleService.getVehicleData(filePath: filePath);
      matcher.fold((l) {
        matcherData = l;
      }, (r) {
        matcherError = r;
      });
      final result = await peopleService.getVehicle(
          page: filePath,
          http: mocPeopleService.getMokClient(filePath: filePath));

      result.fold((l) {
        vehicle = l;
      }, (r) {
        error = 'error';
      });

      expect(vehicle, matcherData);
      expect(error, isEmpty);
      expect(matcherError, error);
    });

    test("get vehicle http timeout test", () async {
      late VehicleModel vehicle;
      String error = '';
      const filePath = 'test/features/home/data/vehicle_data.json';

      final result = await peopleService.getVehicle(
        page: filePath,
        http: mocPeopleService.getMokClient(
          filePath: filePath,
          errorCode: 408, // send the timeout code for test that
        ),
      );

      result.fold((l) {
        vehicle = l;
      }, (r) {
        error = r;
      });

      expect(error, 'Unknow');
    });

    test("get planet http success test", () async {
      const filePath = 'test/features/home/data/planet_data.json';
      late PlanetModel planet;
      late PlanetModel matcherData;
      String error = '';
      String matcherError = '';

      final matcher = await mocPeopleService.getPlanetData(filePath: filePath);
      matcher.fold((l) {
        matcherData = l;
      }, (r) {
        matcherError = r;
      });
      final result = await peopleService.getPlanet(
          page: filePath,
          http: mocPeopleService.getMokClient(filePath: filePath));

      result.fold((l) {
        planet = l;
      }, (r) {
        error = 'error';
      });

      expect(planet, matcherData);
      expect(error, isEmpty);
      expect(matcherError, error);
    });

    test("get planet http timeout test", () async {
      late PlanetModel planet;
      String error = '';
      const filePath = 'test/features/home/data/planet_data.json';

      final result = await peopleService.getPlanet(
        page: filePath,
        http: mocPeopleService.getMokClient(
          filePath: filePath,
          errorCode: 408, // send the timeout code for test that
        ),
      );

      result.fold((l) {
        planet = l;
      }, (r) {
        error = r;
      });

      expect(error, 'Unknow');
    });
  });
}
