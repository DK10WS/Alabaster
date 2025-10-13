import 'dart:async';
import 'package:flutter/material.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late DateTime now;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    scheduleNextUpdate();
  }

  void scheduleNextUpdate() {
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = tomorrow.difference(DateTime.now());

    timer = Timer(durationUntilMidnight, () {
      setState(() {
        now = DateTime.now();
      });
      scheduleNextUpdate();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get _formattedDate {
    final dayName = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ][now.weekday - 1];
    final formattedDate = "${now.day}/${now.month}/${now.year}";
    return "$dayName, $formattedDate";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.transparent),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            _formattedDate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 100,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
