import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'splashview_presenter.dart';
import 'settings_view.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Remind Meow"),
          backgroundColor: Colors.purple[400],
        ),
        body: SplashView()
    );
  }
}

class SplashView extends StatefulWidget{
  SplashView({ Key key }) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> implements SplashViewContract {
  SplashViewPresenter _presenter;

  _SplashViewState() {
    _presenter =  SplashViewPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.load();
  }

  @override
  void onLoadComplete() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new SettingsPage(),
        title: new Text('R E M I N D   M E O W',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34.0
          ),),
        image: new Image.asset('assets/phone_cat_icon.png'),
        backgroundColor: Colors.grey[400],
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 128.0,
        onClick: () => print("MEOW !!"),
        loaderColor: Colors.purple[400]
    );
  }
}