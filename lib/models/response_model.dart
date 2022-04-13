// To parse this JSON data, do
//
//     final responseModel = responseModelFromMap(jsonString);

import 'dart:convert';

class ResponseModel {
  ResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final dynamic data;

  factory ResponseModel.fromJson(String str) =>
      ResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseModel.fromMap(Map<String, dynamic> json) => ResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
