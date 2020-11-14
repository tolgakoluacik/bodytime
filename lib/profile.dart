import 'dart:convert';

import 'package:bodytime/configurations.dart';
import 'package:flutter/material.dart';

import 'configurations.dart';
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

  Widget _buildProfileText(String name) {
    String firstLetter = name.split(" ")[0][0];
    String secondLetter = name.split(" ")[1][0];

    return Container(
      padding: EdgeInsets.all(33),
      decoration: BoxDecoration(
        color: _subscriber.gender == 'erkek' ? Color(0xFF138BF2) : Color(0xFFC003D9),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Text(
        firstLetter + secondLetter,
        style: TextStyle(
          color: Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildProfileText(_subscriber.name),
          ),
          Expanded(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        _buildProperty(Icons.contacts, _subscriber.name, 20),
                        _buildProperty(Icons.phone, _subscriber.phone, 28),
                        _buildProperty(Icons.event, _subscriber.birthYear, 90),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              widget.onClickLogout();
            },
            child: Text(
              "Oturumu Kapat",
              style: TextStyle(color: Colors.white),
            ),
            color: SECONDARY_DARK_COLOR,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildProperty(IconData icon, String text, double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        color: Color(0xFFF2F1F7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: SECONDARY_COLOR,
              size: 32,
            ),
            SizedBox(
              width: size,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: SECONDARY_COLOR,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
