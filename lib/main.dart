import 'package:bodytime/dashboard.dart';
import 'package:bodytime/login.dart';
import 'package:bodytime/measurement.dart';
import 'package:bodytime/nutrition.dart';
import 'package:bodytime/profile.dart';
import 'package:bodytime/reservations.dart';
import 'package:bodytime/splash.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:bodytime/configurations.dart';

import 'configurations.dart';
import 'utils/preferences.dart';

// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//   if (message.containsKey('data')) {
//     // Handle data message
//     final dynamic data = message['data'];
//   }
//
//   if (message.containsKey('notification')) {
//     // Handle notification message
//     final dynamic notification = message['notification'];
//   }
//
//   // Or do other work.
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Time',
      theme:
          ThemeData(primaryColor: SECONDARY_COLOR, accentColor: PRIMARY_COLOR),
      home: MyHomePage(title: 'Body Time'),
      routes: {
        '/turnstile' : (context) => Profile(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _appLoading = true;
  bool _loggedIn = false;
  Widget _body;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // var initializationSettingsAndroid =
  //     AndroidInitializationSettings("ic_launcher");
  // var initializationSettingsIOS =
  //     IOSInitializationSettings(onDidReceiveLocalNotification: (i, s1, s2, s3) {
  //   print(s1 + s2 + s3);
  // });
  // var initializationSettings;
  //
  // _initializeNotificationSettings() async {
  //   initializationSettings = InitializationSettings(
  //       initializationSettingsAndroid, initializationSettingsIOS);
  //
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: (s1) {
  //     print(s1);
  //   });
  // }
  //
  // _showLocalNotification(String title, String body) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'your channel id', 'your channel name', 'your channel description',
  //       importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, title, body, platformChannelSpecifics,
  //       payload: 'Tıklandı !!!!!!!!!!!!!');
  // }

  int _selectedIndex = 0;

  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
      _body = _showPage(_selectedIndex);
    });
  }

  onDashboardItemSelected(index) {
    setState(() {
      _selectedIndex = index;
      _body = _showPage(index);
    });
  }

  Widget _showPage(int selectedIndex) {
    if (selectedIndex == 0)
      return Dashboard(onSelected: onDashboardItemSelected);
    if (selectedIndex == 1) return ReservationList();
    if (selectedIndex == 2) return Nutrition();
    if (selectedIndex == 3) return Measurement();
    if (selectedIndex == 4)
      return Profile(onClickLogout: () {
        Storage.putString("token", null);
        Storage.putString("sessionUser", null);
        setState(() {
          _loggedIn = false;
        });
      });
    return Container();
  }

  @override
  void initState() {
    super.initState();

    _body = Dashboard(onSelected: onDashboardItemSelected);

    Storage.getInstance().then((value) {
      if (Storage.getString("token") != null &&
          Storage.getString("sessionUser") != null) {
        setState(() {
          _loggedIn = true;
        });
      }
    });

    // _initializeNotificationSettings();
    //
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //
    //     _showLocalNotification("Message!", message["data"]["msg"]);
    //
    //     /*showDialog(
    //       context: context,
    //       builder: (BuildContext context) => AlertDialog(
    //         title: null,
    //         content: Text(),
    //         actions: [
    //           FlatButton(
    //             child: Text('Ok'),
    //             onPressed: () async {
    //               Navigator.of(context, rootNavigator: true).pop();
    //             },
    //           )
    //         ],
    //       ),
    //     );*/
    //   },
    //   onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
    //
    // _firebaseMessaging.getToken().then((token) {
    //   print("firebase token is: $token");
    // });

    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _appLoading = false;
      });
    });
  }

  Widget buildBodyWithSession() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: GestureDetector(
          onTap: () async {},
          child: Image.network(
            "https://www.bodytime01.com/assets/img/logo.png",
            height: 50,
          ),
        ),
        backgroundColor: SECONDARY_COLOR,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: SECONDARY_COLOR),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _changePage,
            type: BottomNavigationBarType.fixed,
            fixedColor: PRIMARY_COLOR,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                title: Text(
                  'Anasayfa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event),
                title: Text(
                  'Randevular',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.donut_small),
                title: Text(
                  'Beslenme',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.accessibility_new),
                title: Text(
                  'Olcum',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text(
                  'Profil',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
      /*drawer: DrawerLayout([
            new DrawerMenuItem("Profile", Icons.account_circle, () {
              setState(() {
                _body = Profile();
              });
            }),
            new DrawerMenuItem("Dashboard", Icons.dashboard, () {
              setState(() {
                _body = Dashboard();
              });
            }),
            new DrawerMenuItem("Turnstile", Icons.transit_enterexit, () {
              setState(() {
                _body = TurnStile();
              });
            }),
            new DrawerMenuItem("Çıkış", Icons.exit_to_app, () {
              setState(() {
                _body = Profile(onClickLogout: () {
                  Storage.putString("token", null);
                  Storage.putString("sessionUser", null);
                  _loggedIn = false;
                });
              });
            }),
          ]),*/
      body: _body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _appLoading
        ? Scaffold(body: Splash())
        : (!_loggedIn
            ? Scaffold(body: Login(() {
                setState(() {
                  _loggedIn = true;
                });
              }))
            : buildBodyWithSession());
  }
}
