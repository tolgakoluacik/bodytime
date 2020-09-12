import 'package:bodytime/configurations.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SECONDARY_COLOR,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.network("https://image.freepik.com/free-vector/profile-icon-male-avatar-hipster-man-wear-headphones_48369-8728.jpg"),
        ),
      ),
    );
  }
}
