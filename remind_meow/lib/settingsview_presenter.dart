import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class SettingsViewContract {
  void onAlarmScheduledSuccess();
  void onAlarmScheduledError();
  Future onDidRecieveLocalNotification(int id, String title, String body, String payload);
  Future onSelectNotification(String payload);
}

class SettingsViewPresenter {
  SettingsViewContract _view;
  //SettingsRepository _repository;

  SettingsViewPresenter(this._view) {
    //_repository = new Injector().settingsRepository;
  }

  void initialize() {
    assert(_view != null);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: this._view.onDidRecieveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: this._view.onSelectNotification);
  }

  void scheduleAlarm() {
    assert(_view != null);
    _view.onAlarmScheduledSuccess();
  }
}