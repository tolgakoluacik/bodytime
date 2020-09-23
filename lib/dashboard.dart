import 'dart:convert';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bodytime/configurations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/subscriber.dart';
import 'utils/preferences.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title, this.onSelected}) : super(key: key);

  final String title;
  final Function(int) onSelected;
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

  Widget generateMenuCell(Color color, IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () => widget.onSelected(index),
      child: Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Kalan Seans Sayisi:",
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
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        width: 400,
                        dismissOnTouchOutside: false,
                        dialogType: DialogType.NO_HEADER,
                        btnOkIcon: Icons.launch,
                        btnOkText: "Turnikeyi Ac",
                        btnCancelIcon: Icons.cancel,
                        btnCancelText: "Vazgec",
                        useRootNavigator: true,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'BodyTime\'a Hosgeldiniz!',
                        desc:
                            'Bu islemi gerceklestirebilmek icin randevu saatinizden en az 10 dakika once salonda olmalisiniz. Tek Kullanim Hakkiniz Bulunmaktadir.',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                    },
                    color: PRIMARY_COLOR,
                    child: Text(
                      "Salona Giris Yap",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                generateMenuCell(
                    Color(0xFFF6334B), Icons.event, "Randevular", 1),
                generateMenuCell(
                    Color(0xFF33ABF5), Icons.donut_small, "Beslenme", 2),
                generateMenuCell(Color(0xFF9683A3), Icons.accessibility_new,
                    "Vucut Olcum", 3),
                generateMenuCell(Color(0xFFB3B2B0), Icons.book, "Paketler", 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
