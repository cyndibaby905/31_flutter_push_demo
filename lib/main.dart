import 'package:flutter/material.dart';
import 'package:flutter_push_plugin/flutter_push_plugin.dart';
import 'package:flutter/services.dart';


FlutterPushPlugin fpush = new FlutterPushPlugin();

void main() {

  fpush.setupWithAppID("eb6cf0ff7e7219df98cb8b05");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _regID = 'Unknown';
  String _notification = "";

  @override
  void initState() {
    super.initState();
    fpush.setOpenNotificationHandler((String message) async {
      setState(() {
        _notification = message;
      });
    });
    initPlatformState();

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String regID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      regID = await fpush.registrationID;
    } on PlatformException {
      regID = 'Failed';
    }
    print(regID);


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    setState(() {
      _regID = regID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Running on: $_regID\n'),
              Text('Notification Received: $_notification')
            ],
          ),
        ),
      ),
    );
  }
}
