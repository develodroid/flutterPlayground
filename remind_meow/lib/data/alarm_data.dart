import 'dart:async';
import 'package:intl/intl.dart';

class Alarm {

  static final DateFormat _formatter = DateFormat('MMMM d, yyyy');

  final String title;
  final String description;
  final String birthday;

  const Alarm({this.title, this.description, this.birthday});

  Alarm.fromMap(Map<String, dynamic>  map) :
        title = map['title'],
        description = map['description'],
        birthday = _formatter.format(DateTime.parse(map['dob']['date']));
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