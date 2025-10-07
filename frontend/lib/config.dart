import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

class AnalogClockConfig {
  // Analog Clock
  DateTime time = DateTime.now();
  Color? hourHandColor = Colors.purple[900];
  Color? minuteHandColor = Colors.cyan;
  Color? secondHandColor = Colors.yellow;
  Color? hourNumberColor = Colors.white;
  Color? centerPointColor = Colors.yellow;
}

class DigitalClockConfig {
  //Digital Clock
  // To find your TimeZone checkout https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  final continent = "Europe";
  final city = "London";
  late final location = tz.getLocation('$continent/$city');
  late final time = tz.TZDateTime.now(
    location,
  ); // If you want system time change this line to `DateTime.now()`
}
