library constants;

import 'package:flutter/material.dart';

enum ApplicationMode {
  DEV,
  LIVE
}

const APPLICATION_MODE = ApplicationMode.DEV;

const Color PRIMARY_COLOR = Color(0xFFFF6700);
const Color SECONDARY_COLOR = Color(0xFF4E546C);
const Color SECONDARY_DARK_COLOR = Color(0xFF3A3F51);

const String REST_TOKEN_DEV = "";
const String REST_TOKEN_LIVE = "";

const String WEBSERVICE_URL_DEV = "https://api.bodytime01.com:10011/api/";
const String WEBSERVICE_URL_LIVE = "https://api.bodytime01.com:10011/api/";

const String MAPS_API_KEY = "";

String getToken() {
  switch (APPLICATION_MODE) {
    case ApplicationMode.DEV:
      return REST_TOKEN_DEV;
    case ApplicationMode.LIVE:
      return REST_TOKEN_LIVE;
  }
}

String getWebserviceUrl() {
  switch (APPLICATION_MODE) {
    case ApplicationMode.DEV:
      return WEBSERVICE_URL_DEV;
    case ApplicationMode.LIVE:
      return WEBSERVICE_URL_LIVE;
  }
}