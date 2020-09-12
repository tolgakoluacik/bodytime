import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bodytime/configurations.dart' as Configurations;

enum RequestType {
  GET,
  POST
}

const DEBUG = true;

abstract class BaseCall<ResultType> {

  String get requestUrl;
  Map<String, Object> get body;
  RequestType get requestType;

  Future<ResultType> call() async {

    var url = Configurations.getWebserviceUrl() + requestUrl;
    var response;

    if (DEBUG) print('---- HttpCall Start -----------------------------------------------------------------------------------');
    if (requestType == RequestType.GET) {

      if (DEBUG) print('---- HttpGet: $url');
      response = await http.get(url);

    } else if (requestType == RequestType.POST) {

      body.putIfAbsent('token', () => Configurations.getToken());

      if (DEBUG) print('---- HttpPost: $url');
      if (DEBUG) print('---- Request Params: $body');
      response = await http.post(url, body: body);
    }

    if (DEBUG) print('---- Response Status: ${response.statusCode}');
    if (DEBUG) print('---- Response Body: ${response.body}');
    if (DEBUG) print('---- HttpCall End -------------------------------------------------------------------------------------');

    if (response.statusCode != 200) {
      throw HttpException("Kan geen verbinding maken, probeer later nog eens.");
    }

    var decoded = json.decode(response.body);

    if (decoded["messageCode"] != 107) {
      throw HttpException("Kan geen verbinding maken, probeer later nog eens.");
    }

    if (decoded["data"] == null && (decoded["dataList"] == null || !(decoded["dataList"] is List))) {
      throw HttpException("Kan geen verbinding maken, probeer later nog eens.");
    }

    return parse(decoded["data"], decoded["dataList"]);
  }

  ResultType parse(dynamic data, List dataList);
}

abstract class BaseGetCall<ResultType> extends BaseCall<ResultType> {

  String get requestUrl;
  Map<String, Object> get body => null;
  RequestType get requestType => RequestType.GET;
}

abstract class BasePostCall<ResultType> extends BaseCall<ResultType> {

  Map<String, Object> _body = new Map();

  String get requestUrl;
  Map<String, Object> get body => _body;
  RequestType get requestType => RequestType.POST;
}