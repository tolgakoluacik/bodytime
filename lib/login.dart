import 'package:bodytime/api/define_password.dart';
import 'package:bodytime/api/login.dart';
import 'package:bodytime/api/register.dart';
import 'package:bodytime/api/verify_user.dart';
import 'package:bodytime/forgot_password.dart';
import 'package:bodytime/utils/preferences.dart';
import 'package:flutter/material.dart';

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

  String _phone = '';
  String _password = '';
  String _verificationCode = '';
  String _definePasswordToken = '';
  bool _isLogin = true;
  bool _isRegister = false;
  bool _isVerification = false;
  bool _isDefinePassword = false;

  var _textField = TextEditingController();
  var _textField2 = TextEditingController();

  void _clearTextField() {
    _textField.clear();
    _textField2?.clear();
  }

  void _showMaterialDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                FlatButton(
                  child: Text('Kapat'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin == true
        ? _buildLogin()
        : (_isRegister == true
            ? _buildRegister()
            : (_isVerification == true
                ? _buildVerification()
                : (_isDefinePassword == true
                    ? _buildDefinePassword()
                    : _buildLogin())));
  }

  Widget _buildLogin() {
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
                          controller: _textField,
                          onChanged: (phone) {
                            setState(() {
                              _phone = phone.trim();
                            });
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Telefon Numarası",
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
                          controller: _textField2,
                          onChanged: (password) {
                            setState(() {
                              _password = password.trim();
                            });
                          },
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFFF6700),
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // if (_onAuthorized != null) {
                      //   _onAuthorized.call();
                      // }
                      LoginRequest(_phone, _password).call().then((result) {
                        Storage.putString("token", result.token);
                        _onAuthorized();
                      });
                    },
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36.0, vertical: 16.0),
                        child: Text(
                          "Kayıt Ol",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _clearTextField();
                      setState(() {
                        _isLogin = false;
                        _isRegister = true;
                      });
                    },
                  ),
                ],
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

  Widget _buildRegister() {
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
                          controller: _textField,
                          onChanged: (phone) {
                            setState(() {
                              _phone = phone.trim();
                            });
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Telefon Numarası",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36.0, vertical: 16.0),
                        child: Text(
                          "Kayıt Ol",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _clearTextField();
                      RegisterRequest(_phone).call().then((result) {
                        if (result.success == true)
                          setState(() {
                            _isLogin = false;
                            _isRegister = false;
                            _isVerification = true;
                          });
                      });
                    },
                  ),
                ],
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
                        'Hesabiniz mi var?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _isLogin = true;
                      });
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

  Widget _buildVerification() {
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
                          controller: _textField,
                          onChanged: (verificationCode) {
                            setState(() {
                              _verificationCode = verificationCode.trim();
                            });
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Dogrulama Kodu",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36.0, vertical: 16.0),
                        child: Text(
                          "Gonder",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _clearTextField();
                      VerificationRequest(_phone, _verificationCode)
                          .call()
                          .then((result) {
                        if (result.success == true) {
                          _definePasswordToken = result.definePasswordToken;
                          setState(() {
                            _isLogin = false;
                            _isRegister = false;
                            _isVerification = false;
                            _isDefinePassword = true;
                          });
                        }
                      });
                    },
                  ),
                ],
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

  Widget _buildDefinePassword() {
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
                          onChanged: (password) {
                            setState(() {
                              _password = password.trim();
                            });
                          },
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Sifre",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36.0, vertical: 16.0),
                        child: Text(
                          "Sifreyi Kaydet",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      DefinePasswordRequest(
                              _phone, _password, _definePasswordToken)
                          .call()
                          .then((result) {
                        if (result.success == true) {
                          setState(() {
                            _isLogin = false;
                            _isRegister = false;
                            _isVerification = false;
                            _isDefinePassword = false;
                          });
                        }
                      });
                    },
                  ),
                ],
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
