import 'package:flutter/material.dart';
import 'package:pomodoro/utils/myapp.dart';
import 'package:pomodoro/utils/test.dart';
import 'home_page.dart';

void main() => runApp(Pomodoro());

class Pomodoro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF2A2B4D),
        primaryColor: const Color(0xFF2A2B4D),
        fontFamily: 'Quicksand-Variable',
      ),
      home:  MyHome(),
    );
  }
}
