import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  Splash({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
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

  Widget generateMenuCell(Color color, IconData icon, String text, {Action onClick}) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF4E546C),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.network("https://www.bodytime01.com/assets/img/logo.png"),
        ),
      ),
    );
  }
}
