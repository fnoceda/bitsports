// To parse this JSON data, do
//
//     final planetModel = planetModelFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlanetModel extends Equatable {
  PlanetModel({
    required this.name,
    required this.rotationPeriod,
    required this.orbitalPeriod,
    required this.diameter,
    required this.climate,
    required this.gravity,
    required this.terrain,
    required this.surfaceWater,
    required this.population,
    required this.residents,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });

  final String name;
  final String rotationPeriod;
  final String orbitalPeriod;
  final String diameter;
  final String climate;
  final String gravity;
  final String terrain;
  final String surfaceWater;
  final String population;
  final List<String> residents;
  final List<String> films;
  final DateTime created;
  final DateTime edited;
  final String url;

  PlanetModel copyWith({
    String? name,
    String? rotationPeriod,
    String? orbitalPeriod,
    String? diameter,
    String? climate,
    String? gravity,
    String? terrain,
    String? surfaceWater,
    String? population,
    List<String>? residents,
    List<String>? films,
    DateTime? created,
    DateTime? edited,
    String? url,
  }) =>
      PlanetModel(
        name: name ?? this.name,
        rotationPeriod: rotationPeriod ?? this.rotationPeriod,
        orbitalPeriod: orbitalPeriod ?? this.orbitalPeriod,
        diameter: diameter ?? this.diameter,
        climate: climate ?? this.climate,
        gravity: gravity ?? this.gravity,
        terrain: terrain ?? this.terrain,
        surfaceWater: surfaceWater ?? this.surfaceWater,
        population: population ?? this.population,
        residents: residents ?? this.residents,
        films: films ?? this.films,
        created: created ?? this.created,
        edited: edited ?? this.edited,
        url: url ?? this.url,
      );

  factory PlanetModel.fromJson(String str) =>
      PlanetModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlanetModel.fromMap(Map<String, dynamic> json) => PlanetModel(
        name: json["name"],
        rotationPeriod: json["rotation_period"],
        orbitalPeriod: json["orbital_period"],
        diameter: json["diameter"],
        climate: json["climate"],
        gravity: json["gravity"],
        terrain: json["terrain"],
        surfaceWater: json["surface_water"],
        population: json["population"],
        residents: List<String>.from(json["residents"].map((x) => x)),
        films: List<String>.from(json["films"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "rotation_period": rotationPeriod,
        "orbital_period": orbitalPeriod,
        "diameter": diameter,
        "climate": climate,
        "gravity": gravity,
        "terrain": terrain,
        "surface_water": surfaceWater,
        "population": population,
        "residents": List<dynamic>.from(residents.map((x) => x)),
        "films": List<dynamic>.from(films.map((x) => x)),
        "created": created.toIso8601String(),
        "edited": edited.toIso8601String(),
        "url": url,
      };

  @override
  List<Object?> get props => [name];
}
