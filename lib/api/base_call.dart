import 'dart:io';
import 'dart:convert';

import 'package:bodytime/utils/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:bodytime/configurations.dart' as Configurations;

enum RequestType { GET, POST }

const DEBUG = true;

abstract class BaseCall<ResultType> {
  Map<String, String> queryParams = new Map();

  String get requestUrl;

  dynamic get body;

  RequestType get requestType;

  Future<ResultType> call() async {
    var url = Configurations.getWebserviceUrl() + requestUrl;

    if (queryParams.length > 0) {
      url += "?";

      queryParams.forEach((key, value) => {url += key + "=" + value + "&"});

      url = url.substring(0, url.length - 1);
    }

    var response;
    var token = Storage.getString("accessToken");
    Map<String, String> headers = {};

    if (token != null) {
      headers["Authorization"] = "Bearer " + token;
    }

    if (DEBUG)
      print(
          '---- HttpCall Start -----------------------------------------------------------------------------------');

    if (requestType == RequestType.GET) {
      if (DEBUG) print('---- HttpGet: ${url}');
      response = await http.get(url, headers: headers);

    } else if (requestType == RequestType.POST) {
      if (DEBUG) print('---- HttpPost: ${url}');
      if (DEBUG) print('---- Request Params: ${body}');

      headers["Content-Type"] = "application/json";

      response =
          await http.post(url, body: json.encode(body), headers: headers);
    }

    if (DEBUG) print('---- Response Status: ${response.statusCode}');
    if (DEBUG) print('---- Response Body: ${response.body}');
    if (DEBUG)
      print(
          '---- HttpCall End -------------------------------------------------------------------------------------');

    if (response.statusCode != 200) {
      // BackendError backendError;
      // try {
      //   var decodedBody = json.decode(response.body);
      //   if (decodedBody["error"] != null) {
      //     backendError = BackendError(decodedBody["error"]["code"],
      //         decodedBody["error"]["message"], decodedBody["error"]["details"]);
      //   }
      // } catch (e) {}
      //
      // if (backendError != null) {
      //   throw backendError;
      // } else {
      //   throw HttpException("Beklenmedik bir sorun oluştu.");
      // }
      throw HttpException("Beklenmedik bir sorun oluştu.");
    }

    var decoded = json.decode(response.body);

    return parse(decoded);
  }

  ResultType parse(dynamic data);
}

abstract class BaseGetCall<ResultType> extends BaseCall<ResultType> {
  String get requestUrl;

  dynamic get body => null;

  RequestType get requestType => RequestType.GET;
}

abstract class BasePostCall<ResultType> extends BaseCall<ResultType> {
  dynamic _body;

  String get requestUrl;

  dynamic get body => _body;

  RequestType get requestType => RequestType.POST;

  setBody(dynamic body) {
    this._body = body;
  }
}
