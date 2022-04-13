import 'package:bitsports/api/miapi.dart';
import 'package:bitsports/features/home/models/specie_model.dart';
import 'package:bitsports/features/home/models/planet_model.dart';
import 'package:bitsports/features/home/models/success_response_model.dart';
import 'package:bitsports/features/home/models/vehicle_model.dart';
import 'package:bitsports/features/home/repositories/starwars_repository.dart';
import 'package:bitsports/models/response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class StarWarsData implements StarWarsRepository {
  @override
  Future<Either<SuccessResponseModel, String>> getPeople(
      {required String page, required http.Client http}) async {
    final ResponseModel response = await MiApi().getData(url: page, http: http);
    if (response.success) {
      SuccessResponseModel rta = SuccessResponseModel.fromMap(response.data);

      return Left(rta);
    } else {
      print('StarWarsData::error =>' + response.message);
      return Right(response.message);
    }
  }

  @override
  Future<Either<PlanetModel, String>> getPlanet(
      {required String page, required http.Client http}) async {
    ResponseModel response = await MiApi().getData(url: page, http: http);
    if (response.success) {
      final PlanetModel rta = PlanetModel.fromMap(response.data);
      return Left(rta);
    } else {
      print('StarWarsData::error =>' + response.message);
      return const Right('Unknow');
    }
  }

  @override
  Future<Either<SpecieModel, String>> getSpecies(
      {required String page, required http.Client http}) async {
    ResponseModel response = await MiApi().getData(url: page, http: http);

    if (response.success) {
      final SpecieModel rta = SpecieModel.fromMap(response.data);
      return Left(rta);
    } else {
      print('StarWarsData::error =>' + response.message);
      return const Right('Unknow');
    }
  }

  @override
  Future<Either<VehicleModel, String>> getVehicle(
      {required String page, required http.Client http}) async {
    ResponseModel response = await MiApi().getData(url: page, http: http);
    if (response.success) {
      final VehicleModel rta = VehicleModel.fromMap(response.data);
      return Left(rta);
    } else {
      print('StarWarsData::error =>' + response.message);
      return const Right('Unknow');
    }
  }
}
