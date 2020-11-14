import 'package:bodytime/configurations.dart';
import 'package:flutter/material.dart';

import 'configurations.dart';
//import 'models/subscriber.dart';
//import 'utils/preferences.dart';

class Nutrition extends StatefulWidget {
  Nutrition({Key key, this.title, this.onClickLogout}) : super(key: key);

  final String title;
  final Function onClickLogout;

  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  //Subscriber _subscriber;

  @override
  void initState() {
    super.initState();

    //_subscriber =
        //Subscriber.fromDynamic(json.decode(Storage.getString("sessionUser")));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Bu Sayfa Yapim Asamasindadir!",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: SECONDARY_COLOR,
          ),
        ),
      ),
    );
  }
}
