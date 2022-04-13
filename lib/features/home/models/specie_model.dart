// To parse this JSON data, do
//
//     final spaciesModel = spaciesModelFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SpecieModel extends Equatable {
  SpecieModel({
    required this.name,
    required this.classification,
    required this.designation,
    required this.averageHeight,
    required this.skinColors,
    required this.hairColors,
    required this.eyeColors,
    required this.averageLifespan,
    required this.homeworld,
    required this.language,
    required this.people,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });

  final String name;
  final String classification;
  final String designation;
  final String averageHeight;
  final String skinColors;
  final String hairColors;
  final String eyeColors;
  final String averageLifespan;
  final String homeworld;
  final String language;
  final List<String> people;
  final List<String> films;
  final DateTime created;
  final DateTime edited;
  final String url;

  SpecieModel copyWith({
    String? name,
    String? classification,
    String? designation,
    String? averageHeight,
    String? skinColors,
    String? hairColors,
    String? eyeColors,
    String? averageLifespan,
    String? homeworld,
    String? language,
    List<String>? people,
    List<String>? films,
    DateTime? created,
    DateTime? edited,
    String? url,
  }) =>
      SpecieModel(
        name: name ?? this.name,
        classification: classification ?? this.classification,
        designation: designation ?? this.designation,
        averageHeight: averageHeight ?? this.averageHeight,
        skinColors: skinColors ?? this.skinColors,
        hairColors: hairColors ?? this.hairColors,
        eyeColors: eyeColors ?? this.eyeColors,
        averageLifespan: averageLifespan ?? this.averageLifespan,
        homeworld: homeworld ?? this.homeworld,
        language: language ?? this.language,
        people: people ?? this.people,
        films: films ?? this.films,
        created: created ?? this.created,
        edited: edited ?? this.edited,
        url: url ?? this.url,
      );

  factory SpecieModel.fromJson(String str) =>
      SpecieModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpecieModel.fromMap(Map<String, dynamic> json) => SpecieModel(
        name: json["name"],
        classification: json["classification"],
        designation: json["designation"],
        averageHeight: json["average_height"],
        skinColors: json["skin_colors"],
        hairColors: json["hair_colors"],
        eyeColors: json["eye_colors"],
        averageLifespan: json["average_lifespan"],
        homeworld: json["homeworld"] == null ? 'Unknow' : json["homeworld"],
        language: json["language"],
        people: List<String>.from(json["people"].map((x) => x)),
        films: List<String>.from(json["films"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "classification": classification,
        "designation": designation,
        "average_height": averageHeight,
        "skin_colors": skinColors,
        "hair_colors": hairColors,
        "eye_colors": eyeColors,
        "average_lifespan": averageLifespan,
        "homeworld": homeworld == null ? null : homeworld,
        "language": language,
        "people": List<dynamic>.from(people.map((x) => x)),
        "films": List<dynamic>.from(films.map((x) => x)),
        "created": created.toIso8601String(),
        "edited": edited.toIso8601String(),
        "url": url,
      };

  @override
  List<Object?> get props => [name];
}
