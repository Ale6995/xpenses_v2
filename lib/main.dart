import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpenses_v2/screens/splash/splash.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Xpenses',
      theme: ThemeData(
          fontFamily: 'aileron',
          brightness: Brightness.light,
          primaryColor: Colors.blue[100],
          highlightColor: Colors.blue[100],
          accentColor: Colors.purple,
          secondaryHeaderColor: Colors.blue,
          backgroundColor: Colors.white,
          cardColor: Colors.red[100],
          focusColor: Colors.green[100]),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'aileron',
          accentColor: Colors.grey[400],
          secondaryHeaderColor: Colors.lime[200],
          highlightColor: Colors.grey[600],
          cardColor: Colors.pink[100],
          focusColor: Colors.teal[200]),
      home: SplashScreen(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
