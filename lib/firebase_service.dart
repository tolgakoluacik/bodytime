import 'package:bodytime/utils/preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Firebase Test Request:

/*
DATA='{"notification": {"body": "Test Message","title": "Test Message"}, "priority": "high", "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}, "to": "fbj6GTc3RM6735uiCwZ12j:APA91bGlXgjMYV0jJo8RDCmcNlwC1XuAp0XIRkceVXLruzqFfV3PjABca18YNk3TWfvp9mIYnSJb6FgQbXlFFgMrgAsyDvlQVobSo9POwDkxbUlHSHykTy7EB37AHBSFL2ajKpCKLd9C"}'
curl https://fcm.googleapis.com/fcm/send -H "Content-Type:application/json" -X POST -d "$DATA" -H "Authorization: key=AAAAndvgNgo:APA91bFE2BEVaDAsZKzOL9SFuVzBjD7EP5qVuPBGpw0GJyDf2ScTpwSTGkY_UoF4dVslFyd0Uxyv36Z_JbzwheQSeuY4bkbNCjEG9sIqTypwDSwvoKQqMnKHAdj5B8n57U7Hzpc_FJnj"
 */

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
}

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initialize() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings("ic_launcher");
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (i, s1, s2, s3) {
      print(s1 + s2 + s3);
    });
    var initializationSettings;

    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (s1) {
      print(s1);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showLocalNotification("onMessage", message['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        showLocalNotification("onLaunch", message.toString());
      },
      onResume: (Map<String, dynamic> message) async {
        showLocalNotification("onResume", message.toString());
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      Storage.getInstance().then((value) {
        Storage.putString("firebaseToken", token);
      });
    });
  }

  showLocalNotification(String title, String body) async {
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
}
