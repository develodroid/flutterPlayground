import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './data/alarm_data.dart';

abstract class SettingsViewContract {
  void onAlarmScheduledSuccess();
  void onAlarmScheduledError();
  Future onDidReceiveLocalNotification(int id, String title, String body, String payload);
  Future onSelectNotification(String payload);
}

class SettingsViewPresenter {
  SettingsViewContract _view;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  SettingsViewPresenter(this._view);

  void initialize() {
    assert(_view != null);
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: this._view.onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: this._view.onSelectNotification);
  }

  Future scheduleAlarm(Alarm alarm) async {
    assert(_view != null);
    var time = new Time(alarm.hour, alarm.minutes, 0);
    var androidPlatformChannelSpecifics =
    new AndroidNotificationDetails('repeatDailyAtTime remind meow',
        'repeatDailyAtTime remind meow', 'repeatDailyAtTime remind meow');
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
     0, alarm.title, alarm.description, time, platformChannelSpecifics);
     _view.onAlarmScheduledSuccess();
  }

  void testNotificationLocally() {
    assert(_view != null);
    _showSimpleNotification();
    _view.onAlarmScheduledSuccess();
  }

  Future _showSimpleNotification() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'remind meow channel', 'simple notification', 'simple description',
        channelShowBadge: false,
        importance: Importance.Max,
        priority: Priority.High,
        onlyAlertOnce: true);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'FEED ME', 'DISRESPECTFUL HUMAN', platformChannelSpecifics,
        payload: 'BE MY SERVANT');
  }
}