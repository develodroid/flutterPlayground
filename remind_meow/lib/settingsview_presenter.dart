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
  //SettingsRepository _repository;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  SettingsViewPresenter(this._view) {
    //_repository = new Injector().settingsRepository;
  }

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

  void scheduleAlarm(Alarm alarm) {
    assert(_view != null);
    var time = new Time(0, 0, 0);
    var androidPlatformChannelSpecifics =
    new AndroidNotificationDetails('repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    _showNotificationWithNoBadge();
    //flutterLocalNotificationsPlugin.showDailyAtTime(
    // 0,
    //  'show daily title',
    //   'Daily notification shown at approximately ${_toTwoDigitString(alarm.hour)}:${_toTwoDigitString(alarm.minutes)}:${_toTwoDigitString(time.second)}',
    //   time,
    //   platformChannelSpecifics);
    // _view.onAlarmScheduledSuccess();
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future _showNotificationWithNoBadge() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'no badge channel', 'no badge name', 'no badge description',
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