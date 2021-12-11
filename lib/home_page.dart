import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pomodoro/utils/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'countdown_timer.dart';

class HomePage extends StatefulWidget {
  final List<Icon> timesCompleted = [];

  HomePage() {
    // Initialize times completed dot icons
    for (var i = 0; i < 3; i++) {
      timesCompleted.add(
        const Icon(
          Icons.brightness_1_rounded,
          color: Colors.blueGrey,
          size: 5.0,
        ),
      );
    }
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CountDownController _clockController = CountDownController();
  Icon _clockButton = kPlayClockButton; // Initial value
  bool _isClockStarted = false;
  double slider = 1.0;
  bool isvoice = false ;
  int gift = 10;


  // Change Clock button icon and controller
  Future<void> switchClockActionButton() async {
    if (_clockButton == kPlayClockButton) {
      _clockButton = kPauseClockButton;
      if (!_isClockStarted) {
        // Processed on init
        _isClockStarted = true;
        _clockController.start();
      } else {
        // Processed on play
        _clockController.resume();
      }
    } else {
      // Processed on pause
      _clockButton = kPlayClockButton;
      _clockController.pause();
    }
  }
  @override
  Widget build(BuildContext context) {
    int indexTimesCompleted = 0;
    var slidEr = SleekCircularSlider(
        appearance: const CircularSliderAppearance(),
        initialValue: 10.0,
        min: 10,
        max: 120,
        innerWidget: (value) {
          return Center(child: Text(
              '${slider.round()} m',
              style: const TextStyle(fontSize: 30.0),
            ),
          ); // return const Align(alignment:Alignment.center,child: Text('Time'));
        },
        onChange: (double value) {
          setState(() {
            slider = value;
          });
          print(value);
        });
    CountDownTimer _countDownTimer = CountDownTimer(
      duration: slider.round(),
      fillColor: const Color(0xFF22292F),
      onComplete: () {
        setState(() async {
          widget.timesCompleted[indexTimesCompleted] = const Icon(
            Icons.brightness_1_rounded,
            color: Color(0xFF22292F),
            size: 5.0,
          );
          indexTimesCompleted++;
          await NDialog(
            dialogStyle: DialogStyle(titleDivider: true),
            title: const Text("Timer Completed"),
            content: const Text("Time to break."),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.green),
                  ),
                  child: const Text("Start a short break"),
                  onPressed: () {}),
            ],
          ).show(context);
        });
      },
    );
    CircularCountDownTimer clock = CircularCountDownTimer(
      controller: _clockController,
      isReverseAnimation: true,
      ringColor: const Color(0xFF22292F),
      height: 100,
      width: double.infinity,
      autoStart: false,
      duration: _countDownTimer.duration! * 60,
      isReverse: true,
      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      fillColor: _countDownTimer.fillColor!,
      backgroundColor: const Color(0xFF22292F),
      strokeCap: StrokeCap.round,
      onComplete: () {
        Alert(
                context: context,
                title: 'Done',
                style: const AlertStyle(
                  isCloseButton: true,
                  isButtonVisible: false,
                  titleStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
                type: AlertType.success)
            .show()
            .then((value) {
          setState(() {
            gift++;
          });
        });
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset('assets/snaw.gif',fit: BoxFit.cover,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20.0),
                      child: isvoice==false ? IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.headset_off,
                            size: 30,
                          )) : IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.headset,
                            size: 30,
                          )),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      child: Text(
                        '⭐ $gift',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: slidEr,
                ),
                clock,
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: TextButton(
                        onPressed: () {
                          if (_isClockStarted == false) {
                            switchClockActionButton();
                          } else {
                            _clockController.start();
                          }
                        },
                        child: const Text(
                          'Start !',
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
