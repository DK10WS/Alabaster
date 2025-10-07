import 'package:flutter/material.dart';

Widget date() {
  DateTime now = DateTime.now();
  String formattedDate = "${now.day}/${now.month}/${now.year}";
  String dayName;
  switch (now.weekday) {
    case 1:
      dayName = "Monday";
      break;
    case 2:
      dayName = "Tuesday";
      break;
    case 3:
      dayName = "Wednesday";
      break;
    case 4:
      dayName = "Thursday";
      break;
    case 5:
      dayName = "Friday";
      break;
    case 6:
      dayName = "Saturday";
      break;
    case 7:
      dayName = "Sunday";
      break;
    default:
      dayName = "Unknown";
  }
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.transparent),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          "$dayName, $formattedDate",
          style: const TextStyle(color: Colors.white, fontSize: 100),
        ),
      ),
    ),
  );
}
