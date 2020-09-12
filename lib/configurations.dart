library constants;

import 'package:flutter/material.dart';

enum ApplicationMode {
  DEV,
  LIVE
}

const APPLICATION_MODE = ApplicationMode.DEV;

const Color PHENOMENON_PRIMARY_COLOR = Color(0xFFFF6DC8);
const Color PHENOMENON_PRIMARY_DARK_COLOR = Color(0xFFE562B3);
const Color BUSINESS_PRIMARY_COLOR = Color(0xFF6ED3FF);
const Color BUSINESS_PRIMARY_DARK_COLOR = Color(0xFF62BDE5);

Color PRIMARY_COLOR = PHENOMENON_PRIMARY_COLOR;
Color SECONDARY_COLOR = BUSINESS_PRIMARY_COLOR;
Color PRIMARY_DARK_COLOR = PHENOMENON_PRIMARY_DARK_COLOR;
Color SECONDARY_DARK_COLOR = BUSINESS_PRIMARY_DARK_COLOR;

const String REST_TOKEN_DEV = "";
const String REST_TOKEN_LIVE = "";

const String WEBSERVICE_URL_DEV = "http://192.168.1.179:21021/api/";
const String WEBSERVICE_URL_LIVE = "http://95.216.76.140:21021/api/";

const String MAPS_API_KEY = "AIzaSyD8Bkp_UgcucSh2uWH9iDWt-mTwkc96MfA";

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