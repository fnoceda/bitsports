import 'dart:io';
import 'dart:async';

import 'package:bitsports/models/response_model.dart';
import 'package:bitsports/utils/config.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MiApi {
  Future<ResponseModel> getData(
      {required String url, required http.Client http}) async {
    late ResponseModel response;

    Map<String, String> _headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
    };

    try {
      Uri uri = Uri.parse(url);
      if (await _checkInternet()) {
        final request = await http
            .get(uri, headers: _headers)
            .timeout(const Duration(seconds: MyConfig.timeOut));

        print('uri => ' + uri.toString());

        print('request.statusCode => ' + request.statusCode.toString());

        if (request.statusCode == 200) {
          if (request.body.isNotEmpty) {
            var decodedResponse =
                convert.jsonDecode(convert.utf8.decode(request.bodyBytes))
                    as Map<String, dynamic>;
            response = ResponseModel(
                success: true, message: 'OK', data: decodedResponse);
          } else {
            throw PlatformException(
                code: '500', message: 'Failed to Load Data');
          }
        } else {
          throw PlatformException(code: '500', message: 'Failed to Load Data');
        }
      } else {
        throw PlatformException(
            code: '500', message: 'No Internet Access, Please check');
      }
    } on SocketException catch (e) {
      response = ResponseModel(
          success: false,
          message: 'Connect error, Please try again later',
          data: null);
    } on TimeoutException catch (e) {
      response = ResponseModel(
          success: false,
          message: 'Connect error, Please try again later',
          data: null);
    } on PlatformException catch (e) {
      print('error => $e');
      response = ResponseModel(
          success: false, message: e.message.toString(), data: null);
    }

    return response;
  }

  static Future<bool> _checkInternet() async {
    //check internet connection
    bool rta = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      // final result = await InternetAddress.lookup('10.150.10.91');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        rta = true;
        print('tiene internet');
        print(result);
      }
    } on SocketException catch (_) {
      print(_.message);
      print('no hay internet');
      rta = false;
    }
    return rta;
  }

  // Future<ResponseModel> _getTestData(String filePath,
  //     {bool makeError = false}) async {
  //   print('inside test => $filePath');

  //   if (File(filePath).existsSync()) {
  //     print('MiApi::_getTestData=>file exists');
  //   } else {
  //     print('MiApi::_getTestData=>file does not exist');
  //   }

  //   // final fileContents = await rootBundle.loadString(filePath);
  //   final fileContents = await File(filePath).readAsString();
  //   final decodedJson = convert.jsonDecode(fileContents);
  //   if (makeError) {
  //     return ResponseModel(success: false, message: 'error', data: []);
  //   }
  //   return ResponseModel(success: true, message: 'OK', data: decodedJson);
  // }
}
