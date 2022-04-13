// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class VehicleModel extends Equatable {
  VehicleModel({
    required this.name,
    required this.model,
    required this.manufacturer,
    required this.costInCredits,
    required this.length,
    required this.maxAtmospheringSpeed,
    required this.crew,
    required this.passengers,
    required this.cargoCapacity,
    required this.consumables,
    required this.vehicleClass,
    required this.pilots,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });

  final String name;
  final String model;
  final String manufacturer;
  final String costInCredits;
  final String length;
  final String maxAtmospheringSpeed;
  final String crew;
  final String passengers;
  final String cargoCapacity;
  final String consumables;
  final String vehicleClass;
  final List<String> pilots;
  final List<String> films;
  final DateTime created;
  final DateTime edited;
  final String url;

  VehicleModel copyWith({
    String? name,
    String? model,
    String? manufacturer,
    String? costInCredits,
    String? length,
    String? maxAtmospheringSpeed,
    String? crew,
    String? passengers,
    String? cargoCapacity,
    String? consumables,
    String? vehicleClass,
    List<String>? pilots,
    List<String>? films,
    DateTime? created,
    DateTime? edited,
    String? url,
  }) =>
      VehicleModel(
        name: name ?? this.name,
        model: model ?? this.model,
        manufacturer: manufacturer ?? this.manufacturer,
        costInCredits: costInCredits ?? this.costInCredits,
        length: length ?? this.length,
        maxAtmospheringSpeed: maxAtmospheringSpeed ?? this.maxAtmospheringSpeed,
        crew: crew ?? this.crew,
        passengers: passengers ?? this.passengers,
        cargoCapacity: cargoCapacity ?? this.cargoCapacity,
        consumables: consumables ?? this.consumables,
        vehicleClass: vehicleClass ?? this.vehicleClass,
        pilots: pilots ?? this.pilots,
        films: films ?? this.films,
        created: created ?? this.created,
        edited: edited ?? this.edited,
        url: url ?? this.url,
      );

  factory VehicleModel.fromJson(String str) =>
      VehicleModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VehicleModel.fromMap(Map<String, dynamic> json) => VehicleModel(
        name: json["name"],
        model: json["model"],
        manufacturer: json["manufacturer"],
        costInCredits: json["cost_in_credits"],
        length: json["length"],
        maxAtmospheringSpeed: json["max_atmosphering_speed"],
        crew: json["crew"],
        passengers: json["passengers"],
        cargoCapacity: json["cargo_capacity"],
        consumables: json["consumables"],
        vehicleClass: json["vehicle_class"],
        pilots: List<String>.from(json["pilots"].map((x) => x)),
        films: List<String>.from(json["films"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "model": model,
        "manufacturer": manufacturer,
        "cost_in_credits": costInCredits,
        "length": length,
        "max_atmosphering_speed": maxAtmospheringSpeed,
        "crew": crew,
        "passengers": passengers,
        "cargo_capacity": cargoCapacity,
        "consumables": consumables,
        "vehicle_class": vehicleClass,
        "pilots": List<dynamic>.from(pilots.map((x) => x)),
        "films": List<dynamic>.from(films.map((x) => x)),
        "created": created.toIso8601String(),
        "edited": edited.toIso8601String(),
        "url": url,
      };

  @override
  List<Object?> get props => [name];
}
