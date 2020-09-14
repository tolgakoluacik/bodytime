import 'package:bodytime/api/forgot_password.dart';
import 'package:bodytime/api/forgot_password_code.dart';
import 'package:bodytime/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    super.initState();
  }

  String _phone = '';
  String _verificationCode = '';
  String _definePasswordToken = '';

  bool _isReset = true;

  var _textField = TextEditingController();

  void _clearTextField() {
    _textField.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isReset == true
          ? Container(
              color: Color(0xFF4E546C),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          "https://www.bodytime01.com/assets/img/logo.png"),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextField(
                                  controller: _textField,
                                  onChanged: (phone) {
                                    setState(() {
                                      _phone = phone;
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
                      FlatButton(
                        onPressed: () {
                          _clearTextField();
                          ForgotPasswordRequest(_phone).call().then((result) {
                            if (result.success == true) {
                              setState(() {
                                _isReset = false;
                              });
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFF6700),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36.0, vertical: 16.0),
                            child: Text(
                              'Şifre Sıfırla',
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
                            mouseCursor: MouseCursor.defer,
                            hoverColor: Colors.white,
                            child: Container(
                              child: Text(
                                'Hesabınız mı var? Giriş Yap.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              color: Color(0xFF4E546C),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                          "https://www.bodytime01.com/assets/img/logo.png"),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextField(
                                  controller: _textField,
                                  onChanged: (verificationCode) {
                                    setState(() {
                                      _verificationCode = verificationCode;
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
                      FlatButton(
                        onPressed: () {
                          _clearTextField();
                          ForgotPasswordWithCodeRequest(
                                  _phone, _verificationCode)
                              .call()
                              .then((result) {
                            if (result.success == true) {
                              setState(() {
                                _definePasswordToken = result.definePasswordToken;
                              });
                              Storage.putString("definePasswordToken", result.definePasswordToken);
                            }
                          }).whenComplete(
                            () => Navigator.pop(context),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFF6700),
                              borderRadius: BorderRadius.circular(4)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 36.0, vertical: 16.0),
                            child: Text(
                              'Gonder',
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
                            mouseCursor: MouseCursor.defer,
                            hoverColor: Colors.white,
                            child: Container(
                              child: Text(
                                'Hesabınız mı var? Giriş Yap.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
