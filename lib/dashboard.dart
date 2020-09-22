import 'dart:convert';
import 'dart:ui';

import 'package:bodytime/configurations.dart';
import 'package:bodytime/main.dart';
import 'package:bodytime/reservations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/subscriber.dart';
import 'utils/preferences.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Subscriber _subscriber;

  @override
  void initState() {
    super.initState();

    _subscriber =
        Subscriber.fromDynamic(json.decode(Storage.getString("sessionUser")));
  }

  Widget generateMenuCell(Color color, IconData icon, String text,
      {Function onClick}) {
    return Container(
      padding: EdgeInsets.all(20),
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 100,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_subscriber.gender == 'erkek'
                    ? "https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg"
                    : "https://image.freepik.com/free-vector/profile-icon-female-avatar-hipster-woman-wear-headphones_48369-8726.jpg"),
              ),
            ),
          ),
          Text(
            _subscriber.name,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: SECONDARY_COLOR,
                fontSize: 22),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _subscriber.branch,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: SECONDARY_COLOR,
                  fontSize: 18),
            ),
          ),
          Container(
            color: SECONDARY_COLOR,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Kalan Randevu Sayisi:",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  "9",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                generateMenuCell(
                  Color(0xFFF6334B),
                  Icons.event,
                  "Randevular",
                   onClick: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => ReservationList(),
                         // Pass the arguments as part of the RouteSettings. The
                         // DetailScreen reads the arguments from these settings.
                         settings: RouteSettings(
                           arguments: widget.key,
                         ),
                       ),
                     );
                   }
                ),
                generateMenuCell(
                    Color(0xFF33ABF5), Icons.donut_small, "Beslenme"),
                generateMenuCell(
                    Color(0xFF9683A3), Icons.accessibility_new, "Vucut Olcum"),
                generateMenuCell(Color(0xFFB3B2B0), Icons.book, "Paketler"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
