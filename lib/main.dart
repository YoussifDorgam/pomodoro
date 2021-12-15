import 'package:flutter/material.dart';
import 'package:pomodoro/sharedprefrance/cash_helper.dart';
import 'home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await cachHelper.init();
  runApp(Pomodoro());
}

class Pomodoro extends StatelessWidget {
  // final bool? isdark ;
  // Pomodoro(this.isdark);
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
