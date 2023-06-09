import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/screens/sms_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SmsScreen(),
      title: "weather",
      debugShowCheckedModeBanner: false,
    );
  }
}
