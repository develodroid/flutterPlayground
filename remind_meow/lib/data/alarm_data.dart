import 'dart:async';

class Alarm {

  final String title;
  final String description;
  final int    hour;
  final int    minutes;

  const Alarm(this.title, this.description, this.hour, this.minutes);
}

abstract class AlarmRepository {
  Future<Alarm> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}