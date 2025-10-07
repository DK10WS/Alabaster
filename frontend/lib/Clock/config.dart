import 'package:timezone/timezone.dart' as tz;

class AnalogClockConfig {
  // Analog Clock
  bool showDigitalClock = true; // Inside the analog clock
}

class DigitalClockConfig {
  //Digital Clock
  // To find your TimeZone checkout https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  final continent = "Europe";
  final city = "London";
  late final location = tz.getLocation('$continent/$city');
  late final time = tz.TZDateTime.now(
    location,
  ); // If you want systemtime change this line to `DateTime.now()`
}
