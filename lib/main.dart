import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:mobileapp/Profile.dart';
import 'package:mobileapp/Notification.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'package:mobileapp/Activity.dart';
import 'package:mobileapp/weight_provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  var initilizationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initilizationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:(String? payload)async{
    if(payload!=null){
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) =>Weight()),
        ],
        child: MyApp(),
      ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(title: 'Home Page'),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int _counter = 0;
  int selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final _pageOptions = [

    ProfilePage(title: 'Profile'),
    MyHomePage(title: 'Home'),
    ActivityPage(title: 'Activity'),
    NotificationPage(title: 'Notification')

  ];
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  void _incrementCounter() {
    setState(() {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')),
      );

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: _pageOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert_sharp),
            label: 'Notification',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}