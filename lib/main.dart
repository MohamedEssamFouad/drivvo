
import 'package:drivvo/Controller/mainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Controller/AuthController.dart';
import 'Controller/Controller.dart';
import 'Views/Onboard/ONBoard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'Views/authScreen/AuthScreen.dart';
import 'model/initNotifications.dart';
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();

  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); // Use the name of your app icon file

  var initializationSettings = InitializationSettings(

    android: initializationSettingsAndroid, );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  NotificationService.initialize();

SharedPreferences prefs=await SharedPreferences.getInstance();
bool? hasSeenIntro=prefs.getBool('hasSeenIntro')??false;
  Get.put(AuthController());


  Get.put(MainController());


  runApp(MyApp(isFirstLaunch: !hasSeenIntro));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

debugShowCheckedModeBanner: false,
      home: isFirstLaunch?OnBoardSc() : AuthScreen(),
    );
  }
}


