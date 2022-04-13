import 'package:bitsports/features/home/models/planet_model.dart';
import 'package:bitsports/features/home/models/specie_model.dart';
import 'package:bitsports/features/home/models/success_response_model.dart';
import 'package:bitsports/features/home/models/vehicle_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class StarWarsRepository {
// Either<List<PeopleModel>, String>
// return a List<PeopleModel> or a String
// https://pub.dev/packages/dartz

  Future<Either<SuccessResponseModel, String>> getPeople(
      {required String page, required http.Client http});

  Future<Either<SpecieModel, String>> getSpecies(
      {required String page, required http.Client http});

  Future<Either<PlanetModel, String>> getPlanet(
      {required String page, required http.Client http});

  Future<Either<VehicleModel, String>> getVehicle(
      {required String page, required http.Client http});
}
