import 'package:flutter/material.dart';
import 'settingsview_presenter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Remind Meow"),
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
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
  };

  InputType inputType = InputType.both;
  bool editable = true;
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
  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
      new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        /*actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new SecondScreen(payload),
                ),
              );
            },
          )
        ],*/
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Work in Purrrgress"),
          automaticallyImplyLeading: false
      ),
        body: Padding(
          padding: EdgeInsets.all(22.0),
          child: ListView(
            children: <Widget>[
              Text('Format: "${formats[inputType].pattern}"'),

              DateTimePickerFormField(
                inputType: InputType.both,
                format: formats[inputType],
                decoration: InputDecoration(
                    labelText: 'Date/Time', hasFloatingPlaceholder: false),
                onChanged: (dt) => setState(() => date = dt),
              ),

              Text('Date value: $date'),
              SizedBox(height: 16.0),
              RaisedButton(
                onPressed: () => _presenter.scheduleAlarm,
                child: new Text(
                  'Schedule Alarm !',
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

  void updateInputType({bool date, bool time}) {
    date = date ?? inputType != InputType.time;
    time = time ?? inputType != InputType.date;
    setState(() => inputType =
    date ? time ? InputType.both : InputType.date : InputType.time);
  }
}