import 'package:flutter/material.dart';
import 'package:bodytime/configurations.dart';

class TurnStile extends StatefulWidget {
  TurnStile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TurnStileState createState() => _TurnStileState();
}

class _TurnStileState extends State<TurnStile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF4E546C),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0x50FFFFFF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '\'Turnikeyi Aç\' butonuna tıkladığınızda turnike açılacak ve seans sayınız düşecektir.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              FlatButton(
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFF6700),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Turnikeyi Aç',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
