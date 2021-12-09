import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Clock extends StatefulWidget {
  Clock({Key? key}) : super(key: key);

  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.black],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp)),
        child: SafeArea(
          child: Center(
              child: ClockWidget(
            dateTime: dateTime,
          )),
        ),
      ),
    );
  }
}

class ClockWidget extends StatelessWidget {
  final DateTime dateTime;

  const ClockWidget({Key? key, required this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var seconds = dateTime.second.toDouble();
    var minutes = dateTime.minute.toDouble();
    var hours = dateTime.hour.toDouble();
    return SleekCircularSlider(
      appearance: appearance01,
      min: 0,
      max: 59,
      initialValue: seconds,
      innerWidget: (double value) {
        return Align(
          alignment: Alignment.center,
          child: SleekCircularSlider(
            appearance: appearance02,
            min: 0,
            max: 59,
            initialValue: minutes,
            innerWidget: (double value) {
              return Align(
                alignment: Alignment.center,
                child: SleekCircularSlider(
                  appearance: appearance03,
                  min: 0,
                  max: 11,
                  initialValue: hours % 12,
                  innerWidget: (double value) {
                    final h = hours.toInt() < 12
                        ? 'AM ${hours.toInt() % 12}'
                        : 'PM ${hours.toInt() % 12}';
                    final m = minutes.toInt() < 10
                        ? '0${minutes.toInt()}'
                        : minutes.toInt().toString();
                    final s = seconds.toInt() < 10
                        ? '0${seconds.toInt()}'
                        : seconds.toInt().toString();
                    return Center(
                        child: Text(
                      '$h : $m : $s',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ));
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}


final customWidth01 = CustomSliderWidths(trackWidth: 2, progressBarWidth: 10, shadowWidth: 20);
final customColors01 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: Colors.white,
    progressBarColor: Colors.black,
    shadowColor: Colors.grey,
    shadowStep: 10.0,
    shadowMaxOpacity: 0.6);
final CircularSliderAppearance appearance01 = CircularSliderAppearance(
    customWidths: customWidth01,
    customColors: customColors01,
    startAngle: 270,
    angleRange: 360,
    size: 350.0,
    animationEnabled: false);
final customWidth02 = CustomSliderWidths(trackWidth: 5, progressBarWidth: 15, shadowWidth: 30);
final customColors02 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: Colors.white,
    progressBarColor: Colors.black,
    shadowColor: Colors.blue,
    shadowStep: 15.0,
    shadowMaxOpacity: 0.3);
final CircularSliderAppearance appearance02 = CircularSliderAppearance(
    customWidths: customWidth02,
    customColors: customColors02,
    startAngle: 270,
    angleRange: 360,
    size: 290.0,
    animationEnabled: false);
final customWidth03 = CustomSliderWidths(trackWidth: 8, progressBarWidth: 20, shadowWidth: 40);
final customColors03 = CustomSliderColors(
    dotColor: Colors.white.withOpacity(0.8),
    trackColor: Colors.grey,
    progressBarColor: Colors.green,
    shadowColor: Colors.black,
    shadowStep: 20.0,
    shadowMaxOpacity: 0.3);
final CircularSliderAppearance appearance03 = CircularSliderAppearance(
    customWidths: customWidth03,
    customColors: customColors03,
    startAngle: 270,
    angleRange: 360,
    size: 210.0,
    animationEnabled: false);
