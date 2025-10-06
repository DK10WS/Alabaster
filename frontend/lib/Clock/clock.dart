import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          AnalogClock(
            isLive: true,
            hourHandColor: Color(0XFFe363c8),
            minuteHandColor: Colors.cyan,
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.9,
            numberColor: Colors.white,
            datetime: DateTime.now(),
            showTicks: true,
            showDigitalClock: true,
            digitalClockColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
