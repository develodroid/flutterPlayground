import 'dart:async';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text('R E M I N D   M E O W',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36.0
          ),),
        image: new Image.asset('assets/phone_cat_icon.png'),
        backgroundColor: Colors.grey[300],
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 128.0,
        onClick: () => print("MEOW !!"),
        loaderColor: Colors.purple[600]
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Work in Purrrgress"),
          automaticallyImplyLeading: false
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: _showDailyAtTime,
          child: new Text(
            'Demo',
            style: Theme
                .of(context)
                .textTheme
                .headline,
          ),
        ),
      ),
    );
  }
}
Future _showDailyAtTime() async {
  var time = new Time(10, 0, 0);
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description');
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'show daily title',
      'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      time,
      platformChannelSpecifics);
}

Future onDidRecieveLocalNotification(
    int id, String title, String body, String payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  showDialog(
    context: context,
    builder: (BuildContext context) => new CupertinoAlertDialog(
      title: new Text(title),
      content: new Text(body),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: new Text('Ok'),
        )
      ],
    ),
  );
}
}

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }