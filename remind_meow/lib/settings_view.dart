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

  final formats = {
    InputType.time: DateFormat("HH:mm:ss")
  };

  InputType inputType = InputType.time;
  DateTime date;

  _SettingsViewState() {
    _presenter =  SettingsViewPresenter(this);
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
            elevation: 10.0
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
                inputType: InputType.time,
                format: formats[inputType],
                editable: false,
                decoration: InputDecoration(
                    labelText: 'Select daily reminder time', hasFloatingPlaceholder: false, ),
                onChanged: (dt) => setState(() => date = dt),
              ),
              SizedBox(height: 16.0),
              RaisedButton(
                onPressed: () => _presenter.scheduleAlarm(new Alarm("Remind Meow!!", "Take care of me !", date.hour, date.minute)),
                child: new Text(
                  'Save reminder',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline,
                ),
              ),
              RaisedButton(
                onPressed: () => _presenter.testNotificationLocally(),
                child: new Text(
                  'Try out reminder',
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