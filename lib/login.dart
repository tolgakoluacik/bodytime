import 'package:bodytime/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  Function _onAuthorized;

  Login(Function onAuthorized, {Key key, this.title}) : super(key: key) {
    this._onAuthorized = onAuthorized;
  }

  final String title;

  @override
  _LoginState createState() => _LoginState(_onAuthorized);
}

class _LoginState extends State<Login> {
  Function _onAuthorized;

  _LoginState(Function onAuthorized) {
    this._onAuthorized = onAuthorized;
  }

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

  Widget generateMenuCell(Color color, IconData icon, String text,
      {Action onClick}) {
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
    return Container(
      color: Color(0xFF4E546C),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network("https://www.bodytime01.com/assets/img/logo.png"),
              SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0x50FFFFFF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xFF5F657B),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Kullanıcı Adı",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0x50FFFFFF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Row(
                  children: [
                    Container(
                      color: Color(0xFF5F657B),
                      child: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 32,
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Şifre",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              FlatButton(
                onPressed: () {
                  if (_onAuthorized != null) {
                    _onAuthorized.call();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFF6700),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0x50FFFFFF),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: InkWell(
                    child: Container(
                      child: Text(
                        'Şifrenizi mi unuttunuz?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                      );
                    },
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
