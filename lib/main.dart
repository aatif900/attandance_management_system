import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCM1uf22PQMd3eUYHoR8AIGp5I99J5_aWg",
    appId: "1:734326870736:android:d798527a2f32b16ccd44d5",
    messagingSenderId: "734326870736",
    projectId: "attendancemanagementsyst-c8325",
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: Register(),
    );
  }
}
