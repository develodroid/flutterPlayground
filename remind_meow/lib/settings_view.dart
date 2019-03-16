import 'package:flutter/material.dart';
import 'settingsview_presenter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import './data/alarm_data.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Remind Meow"),
          backgroundColor: Colors.purple[400],
        ),
        body: SettingsView()
    );
  }
}

class SettingsView extends StatefulWidget{
  SettingsView({ Key key }) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> implements SettingsViewContract {
  SettingsViewPresenter _presenter;
  InputType _inputType;
  DateTime _date;

  final formats = {
    InputType.time: DateFormat("HH:mm:ss")
  };

  _SettingsViewState() {
    _presenter =  SettingsViewPresenter(this);
    _inputType = InputType.time;

  }

  @override
  void initState() {
    super.initState();
    _presenter.initialize();
  }

  @override
  void onAlarmScheduledSuccess() {
    setState(() {});
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
            title: new Text("Alarm Scheduled"),
            content: new Text("Boooooom"),
            elevation: 10.0,
          )
      );
  }

  @override
  void onAlarmScheduledError() {
    print("Error");
  }

  @override
  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SettingsPage()),
    );
  }

  @override
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
      new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new SettingsPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Padding(
          padding: EdgeInsets.all(22.0),
          child: ListView(
            children: <Widget>[
              Image.asset('assets/review_cat_icon.png'),
              DateTimePickerFormField(
                inputType: _inputType,
                format: formats[_inputType],
                editable: false,
                decoration: InputDecoration(
                    labelText: 'Select daily reminder time', hasFloatingPlaceholder: false),
                onChanged: (dt) => setState(() => _date = dt),
              ),
              SizedBox(height: 16.0),
              new RaisedButton(
                onPressed: () =>  _presenter.scheduleAlarm(new Alarm("Remind Meow!!", "Take care of me !", _date.hour, _date.minute)),
                textColor: Colors.white,
                color: Colors.grey[400],
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  'Save reminder',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline,
                ),
              ),
              new RaisedButton(
                onPressed: () => _presenter.testNotificationLocally(),
                textColor: Colors.black,
                color: Colors.grey[400],
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  'Try Out Reminder',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline,
                ),
              ),
            ],
          ),
        ));
  }
}