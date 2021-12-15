import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/bloc/appcubit.dart';
import 'package:pomodoro/bloc/appstate.dart';
import 'package:pomodoro/sharedprefrance/cash_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CountDownController _clockController = CountDownController(); // CountDownController
  bool _isClockStarted = false; // this variable to toggle between Start time or stop time
  double slider = 1.0; // on change slider time
  bool MusicPlay = false; // this variable to toggle between play music or stop music
 // int gift = 0 ; // stars gifts
  AudioPlayer? player;  // this variable to stop Audio


  // AudioCache fro music
  final AudioCache _audioCache = AudioCache(
    prefix: 'assets/audio/',
    fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
  );
  // AudioCache play
  void _playFile() async {
    player = await _audioCache.loop('appmusic.mp3'); // assign player here
  }
  // AudioCache stop
  void _stopFile() {
    player?.stop(); // stop the file like this
  }
  // Change Clock button icon and controller
  Future<void> switchClockActionButton() async {
    if (_isClockStarted == false) {
      if (!_isClockStarted) {
        // Processed on init
        _isClockStarted = true;
        _clockController.start();
      }
      setState(() {
        _isClockStarted == true;
      });
    } else {
      _clockController.start();
    }
  }
  @override
  Widget build(BuildContext context) {
    // Slider widget
    var slidEr = SleekCircularSlider(
        appearance: const CircularSliderAppearance(),
        initialValue: 25.0,
        min: 10,
        max: 120,
        innerWidget: (value) {
          return Center(
            child: Text(
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
    // Timer widget
    // CircularCountDownTimer clock = CircularCountDownTimer(
    //   controller: _clockController,
    //   isReverseAnimation: true,
    //   ringColor: const Color(0xFF22292F),
    //   height: 100,
    //   width: double.infinity,
    //   autoStart: false,
    //   duration: slider.round() * 60,
    //   isReverse: true,
    //   textStyle: const TextStyle(color: Colors.white, fontSize: 20),
    //   fillColor: const Color(0xFF22292F),
    //   backgroundColor: const Color(0xFF22292F),
    //   strokeCap: StrokeCap.round,
    //   onComplete: () {
    //     if (_isClockStarted == true) {
    //       _isClockStarted = !_isClockStarted;
    //     }
    //     Alert(
    //             context: context,
    //             title: 'Done',
    //             style: const AlertStyle(
    //               isCloseButton: true,
    //               isButtonVisible: false,
    //               titleStyle: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 30.0,
    //               ),
    //             ),
    //             type: AlertType.success)
    //         .show()
    //         .then((value) {
    //
    //     //  print(gift);
    //     });
    //   },
    // );
    return BlocProvider(
      create: (context) => PomodoroCubit(),
      child: BlocConsumer<PomodoroCubit, AppInitialState>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var cubit = PomodoroCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/snaw.gif',
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 20.0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  MusicPlay = !MusicPlay;
                                });
                                if (MusicPlay == true) {
                                  _playFile();
                                } else {
                                  _stopFile();
                                }
                              },
                              icon: Icon((MusicPlay == false)
                                  ? Icons.headset_off
                                  : Icons.headset),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(top: 5 ,start: 10 ,end: 10 ,bottom: 5),
                                child: Text(
                                  '⭐ ${cubit.uid}',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: slidEr,
                      ),
                      CircularCountDownTimer(
                        controller: _clockController,
                        isReverseAnimation: true,
                        ringColor: const Color(0xFF22292F),
                        height: 100,
                        width: double.infinity,
                        autoStart: false,
                        duration: slider.round() * 60,
                        isReverse: true,
                        textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                        fillColor: const Color(0xFF22292F),
                        backgroundColor: const Color(0xFF22292F),
                        strokeCap: StrokeCap.round,
                        onComplete: () {
                          if (_isClockStarted == true) {
                            _isClockStarted = !_isClockStarted;
                          }
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
                                cubit.starsShared();
                            print(cubit.stars);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      if (_isClockStarted == false)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: TextButton(
                              onPressed: () {
                                switchClockActionButton();
                              },
                              child: const Text(
                                'Start !',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              )),
                        ),
                      if (_isClockStarted == true)
                        const Text(
                          'الصبر مفتاح الفرج ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      TextButton(onPressed: () {
                        cachHelper.removeData('stars');
                      }, child: const Text('delete ')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
