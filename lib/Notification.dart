import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:mobileapp/hero_dialogue_route.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:slide_countdown/slide_countdown.dart';


import 'main.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with AutomaticKeepAliveClientMixin {

  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  void scheduleAlarm() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Alarm notification',
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
      priority: Priority.high,
      importance: Importance.max,
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Reminder',
        'Drink Water',
        RepeatInterval.hourly,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        );
  }
  String dropdownValue = '15';
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(width: 20),

              ]
            ),
            ElevatedButton(
                onPressed:(){

                  setState(() {


                  });



                  scheduleAlarm();
            }, child: const Text("Set Hourly Reminder"))

          ],
        ),
      ),

    );
  }
}
