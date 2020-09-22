import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'models/subscriber.dart';
import 'utils/preferences.dart';

class Measurement extends StatefulWidget {
  Measurement({Key key, this.title, this.onClickLogout}) : super(key: key);

  final String title;
  final Function onClickLogout;

  @override
  _MeasurementState createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
  Subscriber _subscriber;

  @override
  void initState() {
    super.initState();

    _subscriber =
        Subscriber.fromDynamic(json.decode(Storage.getString("sessionUser")));

    HtmlEscape htmlEscape = const HtmlEscape();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebviewScaffold(
        url: new Uri.dataFromString('<html><body>'+ _subscriber.measure +'</body></html>', mimeType: 'text/html',  encoding: Encoding.getByName('utf-8')).toString(),
      )
    );
  }
}
