import 'package:flutter/material.dart';
import "package:one_clock/one_clock.dart";
import "package:alabaster/config.dart";

Widget digital_clock1(BuildContext context) {
  String city = DigitalClockConfig().city;
  return Container(
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.7),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.transparent),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DigitalClock(
                format: "Hms",
                isLive: true,
                textScaleFactor: 4,
                digitalClockTextColor: Colors.white,
                datetime: DigitalClockConfig().time,
              ),
              const SizedBox(width: 12),
              Text(
                "| $city",
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget digital_clock2(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.7),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.transparent),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DigitalClock(
                format: "Hms",
                isLive: true,
                textScaleFactor: 4,
                digitalClockTextColor: Colors.white,
                datetime: DateTime.now(),
              ),
              const SizedBox(width: 12),
              Text(
                "| Delhi",
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
