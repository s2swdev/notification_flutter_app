import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/util/const.dart';
import 'package:flutterapp/views/coupon_details.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    this.makeRequest();
    initializing();
  }

  String url = Constants.apiLink + 'product/read_coupon.php';
  List data, data_restaurant;
  List data_detail;
  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["records"];
    });
  }

  Future<String> makeRequest_details(int i) async {
    String url = Constants.apiLink + 'product/read_detail.php?id=' + data[i]["restaurant"]["Org_id"];
    var response = await http.get(Uri.encodeFull(url),
        headers: {"Accept": "application/json"});

    setState(() {
      var extractdata = json.decode(response.body);
      data_detail = extractdata["restaurants"];

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new CouponDetails(data_detail)));
    });
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    //_showNotifications();
  }

  void _showNotifications() async {
    await notification();
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'Channel ID', 'Channel title', 'channel body',
        priority: Priority.High,
        importance: Importance.Max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, data[0]["CouponCode"], data[0]["Discount_offered"], notificationDetails);
  }

  Future onSelectNotification(String test) {
    makeRequest_details(0);
    if (test != null) {
      print("onSelectNotification" + test);
    }

    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
            },
            child: Text("Okay")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              onPressed: _showNotifications,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Show Notification",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
