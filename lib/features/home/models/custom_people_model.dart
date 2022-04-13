// To parse this JSON data, do
//
//     final peopleModel = peopleModelFromMap(jsonString);
import 'package:equatable/equatable.dart';

import 'dart:convert';

//Equatable: Being able to compare objects in Dart often involves having to override the == operator as well as hashCode. https://pub.dev/packages/equatable
class CustomPeopleModel extends Equatable {
  CustomPeopleModel({
    required this.name,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.homeworld,
    required this.species,
    required this.vehicles,
    required this.url,
    // this.speciesStr,
    // this.planetStr,
    this.vehiclesName,
  });

  final String name;

  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String homeworld;
  final List<String> species;
  final List<String> vehicles;
  List<String>? vehiclesName;

  final String url;
  // String? speciesStr;
  // String? planetStr;

  CustomPeopleModel copyWith({
    String? name,
    String? hairColor,
    String? skinColor,
    String? eyeColor,
    String? birthYear,
    String? homeworld,
    List<String>? species,
    List<String>? vehicles,
    List<String>? vehiclesName,
    String? url,
    // String? speciesStr,
    // String? planetStr,
  }) =>
      CustomPeopleModel(
        name: name ?? this.name,
        hairColor: hairColor ?? this.hairColor,
        skinColor: skinColor ?? this.skinColor,
        eyeColor: eyeColor ?? this.eyeColor,
        birthYear: birthYear ?? this.birthYear,
        homeworld: homeworld ?? this.homeworld,
        species: species ?? this.species,
        vehicles: vehicles ?? this.vehicles,
        url: url ?? this.url,
        // speciesStr: speciesStr ?? this.speciesStr,
        // planetStr: planetStr ?? this.planetStr,
        vehiclesName: vehiclesName ?? this.vehiclesName,
      );

  factory CustomPeopleModel.fromJson(String str) =>
      CustomPeopleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomPeopleModel.fromMap(Map<String, dynamic> json) =>
      CustomPeopleModel(
        name: json["name"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        homeworld: json["homeworld"],
        species: List<String>.from(json["species"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        vehiclesName: json["vehiclesName"] == null
            ? []
            : List<String>.from(json["vehiclesName"].map((x) => x)),
        url: json["url"],
        // speciesStr: json["species_str"],
        // planetStr: json["planet_str"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "hair_color": hairColor,
        "skin_color": skinColor,
        "eye_color": eyeColor,
        "birth_year": birthYear,
        "homeworld": homeworld,
        "species": List<dynamic>.from(species.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
        "vehiclesName": (vehiclesName == null) ? [] : vehiclesName,
        "url": url,
        // "species_str": speciesStr,
        // "planet_str": planetStr,
      };

  //
  @override
  List<Object> get props => [
        name,
        hairColor,
        skinColor,
        eyeColor,
        birthYear,
        homeworld,
      ];
}
