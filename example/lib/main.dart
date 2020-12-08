import 'dart:async';

import 'package:flutter/material.dart';
import 'package:umeng_analytics/umeng_analytics.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var result = await UmengAnalyticsPlugin.init(
      androidKey: '5dfc5b91cb23d26df0000a90',
      iosKey: '5dfc5c034ca35748d1000c4c',
    );

    print('Umeng initialized.');

    if (!mounted) {
      return;
    }

    setState(() {
      _platformVersion = result ? 'OK' : 'init error';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: GestureDetector(
          onTap: () {
            _analytics();
          },
          child: Container(
            width: 100,
            height: 50,
            alignment: Alignment.center,
            color: Colors.amberAccent,
            child: Text('Button\n$_platformVersion\n'),
          ),
        ),
      ),
    );
  }

  /// umeng custom envent analytics
  ///see docs https://developer.umeng.com/docs/
  Future<void> _analytics() async {
    //custom event:
    UmengAnalyticsPlugin.event("text_button_click");

    //with label:
    UmengAnalyticsPlugin.event("text_button_click_1", label: "button");

    //with params:
    Map<String, String> params = Map();
    params["page"] = "main";
    params["button_text"] = "test";
    UmengAnalyticsPlugin.event("text_button_click_2", params: params);

    //with eventValue
    params = Map();
    params["page"] = "main";
    params["button_text"] = "test";
    int eventValue = 10;
    UmengAnalyticsPlugin.event("text_button_click_3",
        params: params, eventValue: eventValue);
  }
}
