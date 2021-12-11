import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(Pomodoro());

class Pomodoro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF22292F),
        primaryColor: const Color(0xFF22292F),
        fontFamily: 'Quicksand-Variable',
      ),
      home:HomePage(),
    );
  }
}
