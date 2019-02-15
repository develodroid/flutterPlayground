import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      body: Center(
        child: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/review_cat_icon.png'),
              Image.asset('assets/search_cat_icon.png'),
            ],
          ),
        )
      )
    );
  }
}