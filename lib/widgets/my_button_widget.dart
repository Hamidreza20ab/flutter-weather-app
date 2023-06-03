import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.onPreesed, required this.text});
  final Function() onPreesed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.purple,
        ),
        onPressed: onPreesed,
        child: Text(text),
      ),
    );
  }
}
