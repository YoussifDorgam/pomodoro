import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  double slider00 = 120.0 ;
  @override
  Widget build(BuildContext context) {
    final slider = SleekCircularSlider(
        initialValue: 30.0,
        appearance: const CircularSliderAppearance(
          size: 200.0 ,
          spinnerDuration: 1 ,
          startAngle: 10 ,

        ),
        min: 20,
        max: 70,
        // innerWidget: (value)
        // {
        //   return Text('Time');
        // },
        onChange: (double value) {
          print(value);
        });
    final slider1 = SleekCircularSlider(
      appearance: CircularSliderAppearance(
          customWidths: CustomSliderWidths(progressBarWidth: 10)),
      min: 1,
      max: 28,
      initialValue: 1,
    );
    const slider2 = SleekCircularSlider(
        appearance: CircularSliderAppearance(
          spinnerMode: true,
        ));
    final slider3 = SleekCircularSlider(
      min: 0,
      max: 1000,
      initialValue: 426,
      onChange: (double value) {
        // callback providing a value while its being changed (with a pan gesture)
      },
      onChangeStart: (double startValue) {
        // callback providing a starting value (when a pan gesture starts)
      },
      onChangeEnd: (double endValue) {
        // ucallback providing an ending value (when a pan gesture ends)
      },
      innerWidget: (double value) {
        return Text('dasd');
        // use your custom widget inside the slider (gets a slider value from the callback)
      },
    );
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200.0,),
          Slider(
            inactiveColor : Colors.black ,
            activeColor: Colors.amber,
            value: slider00,
            max: 220.0,
            min: 80.0,
            onChanged: (value)
            {
              setState(() {
                slider00 = value ;
              });

            },
          ),
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: slider,
          ),



        ],
      ),
    );
  }
}
