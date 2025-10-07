import 'package:flutter/material.dart';
import "package:alabaster/config.dart";
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

Widget clock1(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.transparent, width: 2),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(
        20,
      ), // clip the child to match corners
      child: AnalogClock(
        dateTime: AnalogClockConfig().time,
        dialColor: Colors.transparent,
        hourHandColor: AnalogClockConfig().hourHandColor,
        minuteHandColor: AnalogClockConfig().minuteHandColor,
        secondHandColor: AnalogClockConfig().secondHandColor,
        hourNumberColor: AnalogClockConfig().hourNumberColor,
        markingColor: Colors.transparent,
        centerPointColor: AnalogClockConfig().centerPointColor,
      ),
    ),
  );
}

Widget clock2(BuildContext context) {
  return Container();
}
