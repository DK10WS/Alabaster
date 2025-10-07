import 'package:alabaster/Clock/config.dart';
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Analog Clock
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.5,
              child: AnalogClock(
                isLive: true,
                hourHandColor: const Color(0xFFe363c8),
                minuteHandColor: Colors.cyan,
                numberColor: Colors.white,
                secondHandColor: Colors.yellow,
                datetime: DateTime.now(),
                showTicks: true,
                showDigitalClock: AnalogClockConfig().showDigitalClock,
                digitalClockColor: Colors.white,
                showAllNumbers: true,
              ),
            ),

            // Digital Clock
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.5,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: DigitalClock(
                    format: "Hms",
                    isLive: true,
                    textScaleFactor: 3,
                    digitalClockTextColor: Colors.white,
                    datetime: DigitalClockConfig().time,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
