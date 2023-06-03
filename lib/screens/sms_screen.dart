// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/widgets/my_button_widget.dart';
import 'package:weatherapp/widgets/my_textfield.dart';
import 'package:http/http.dart' as http;

class SmsScreen extends StatefulWidget {
  const SmsScreen({super.key});

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  TextEditingController phoneController = TextEditingController();

  TextEditingController activeCodeController = TextEditingController();
  bool isVisible = false;
  int activeCode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("احراز هویت"),
        centerTitle: true,
        leading: Icon(Icons.sms_outlined),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
                controller: phoneController,
                hintText: 'شماره تلفن',
                type: TextInputType.number),
            Visibility(
              visible: isVisible,
              child: MyTextField(
                  controller: activeCodeController,
                  hintText: 'کد فعالسازی',
                  type: TextInputType.number),
            ),
            ButtonWidget(
              text: isVisible ? 'فعال سازی' : 'ارسال کد',
              onPreesed: () async {
                if (isVisible == false) {
                  if (phoneController.text.isNotEmpty) {
                    setState(() {
                      isVisible = true;
                      activeCode = 10000 + Random().nextInt(89999);
                      Uri urlAuth = Uri.parse(
                          'https://api.kavenegar.com/v1/644D336B5A374148464E34694F76487A6D61676A473945766B69566F6B78313365727841514730313555413D/verify/lookup.json?receptor=${phoneController.text}&token=${activeCode}&template=Hamidreza-verify-test');
                      http.post(urlAuth);
                    });
                  }
                } else {
                  if (activeCodeController == activeCode.toString()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isActive', true);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
