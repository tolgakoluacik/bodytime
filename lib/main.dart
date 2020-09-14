import 'package:bodytime/dashboard.dart';
import 'package:bodytime/login.dart';
import 'package:bodytime/models/drawer_menu_item.dart';
import 'package:bodytime/profile.dart';
import 'package:bodytime/splash.dart';
import 'package:bodytime/turnstile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bodytime/configurations.dart';
import 'package:bodytime/drawer_layout.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Time',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Body Time'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _appLoading = true;
  bool _loggedIn = false;
  Widget _body = Dashboard();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      AndroidInitializationSettings("ic_launcher");
  var initializationSettingsIOS =
      IOSInitializationSettings(onDidReceiveLocalNotification: (i, s1, s2, s3) {
    print(s1 + s2 + s3);
  });
  var initializationSettings;

  _initializeNotificationSettings() async {
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (s1) {
      print(s1);
    });
  }

  _showLocalNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'Tıklandı !!!!!!!!!!!!!');
  }

  int _selectedIndex = 0;

  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
      _body = _showPage(_selectedIndex);
    });
  }

  Widget _showPage(int selectedIndex) {
    if (selectedIndex == 0) return Dashboard();
    if (selectedIndex == 1) return Dashboard();
    if (selectedIndex == 2) return Dashboard();
    if (selectedIndex == 3) return Dashboard();
    if (selectedIndex == 4) return Profile();
  }

  @override
  void initState() {
    super.initState();

    _initializeNotificationSettings();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        _showLocalNotification("Message!", message["data"]["msg"]);

        /*showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: null,
            content: Text(),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          ),
        );*/
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _firebaseMessaging.getToken().then((token) {
      print("firebase token is: $token");
    });

    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        _appLoading = false;
      });
    });
  }

  Widget buildBodyWithSession() {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: GestureDetector(
            onTap: () async {},
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: PRIMARY_COLOR,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: PRIMARY_COLOR),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _changePage,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.white,
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
        drawer: DrawerLayout([
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
              _loggedIn = false;
              _body = Profile();
            });
          }),
        ]),
        body: _body);
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
