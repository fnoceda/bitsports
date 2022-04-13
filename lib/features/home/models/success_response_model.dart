// To parse this JSON data, do
//
//     final successResponseModel = successResponseModelFromMap(jsonString);

import 'dart:convert';

class SuccessResponseModel {
  SuccessResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  final dynamic next;
  final dynamic previous;
  final List<dynamic> results;

  SuccessResponseModel copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<dynamic>? results,
  }) =>
      SuccessResponseModel(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory SuccessResponseModel.fromJson(String str) =>
      SuccessResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuccessResponseModel.fromMap(Map<String, dynamic> json) =>
      SuccessResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<dynamic>.from(json["results"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x)),
      };
}
