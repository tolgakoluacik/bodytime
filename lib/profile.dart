import 'dart:convert';

import 'package:bodytime/configurations.dart';
import 'package:flutter/material.dart';

import 'configurations.dart';
import 'models/subscriber.dart';
import 'models/subscriber.dart';
import 'utils/preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.title, this.onClickLogout}) : super(key: key);

  final String title;
  final Function onClickLogout;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Subscriber _subscriber;

  @override
  void initState() {
    super.initState();

    _subscriber =
        Subscriber.fromDynamic(json.decode(Storage.getString("sessionUser")));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: SECONDARY_COLOR,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  "https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg"),
            ),
          ),
          Text(_subscriber.name, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 22),),
          Text(_subscriber.phone, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),),
          Text(_subscriber.birthYear, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18),),
          Expanded(child: Container(),),
          RaisedButton(
            onPressed: () {
              widget.onClickLogout();
            },
            child: Text("Oturumu Kapat", style: TextStyle(color: Colors.white),),
            color: SECONDARY_DARK_COLOR,
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
