import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  Widget listItem(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 26,
          ),
          Container(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ))
        ],
      ),
    );
  }

  Widget generateMenuCell(Color color, IconData icon, String text, {Function onClick}) {
    return Container(
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
    return GridView.count(
      crossAxisCount: 2,
      children: [
        generateMenuCell(
            Color(0xFFFD7C7C), Icons.assignment_turned_in, "My Diseases"),
        generateMenuCell(
            Color(0xFF28ABEC), Icons.add_a_photo, "My Prescription"),
        generateMenuCell(Color(0xFF5BCDE5), Icons.account_circle, "Title 3"),
        generateMenuCell(Color(0xFF616A7F), Icons.satellite, "Giriş Yap"),
        generateMenuCell(Color(0xFFFEB88D), Icons.desktop_mac, "Title 5"),
        generateMenuCell(Color(0xFF1DD2AF), Icons.call, "Title 6"),
        generateMenuCell(Color(0xFFA16186), Icons.verified_user, "Title 7"),
        generateMenuCell(Color(0xFFC05351), Icons.backspace, "Title 8"),
      ],
    );
  }
}
