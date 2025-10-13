import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

// Using this not to get rate limited
Map<String, double>? cachedLocation;

Future<Map<String, double>?> getlocation() async {
  if (cachedLocation != null) {
    return cachedLocation;
  }

  final response = await http.get(
    Uri.parse("https://ipapi.co/json/"),
    headers: {
      'User-Agent': 'Mozilla/5.0 (Flutter App; Linux x86_64)',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    double lat = data['latitude'];
    double lon = data['longitude'];
    cachedLocation = {'lat': lat, 'lon': lon};
    return cachedLocation;
  } else {
    print("Failed to fetch location, code: ${response.statusCode}");
  }
  if (response.statusCode != 200) {
    print("Failure to get lat and lon");
    return null;
  }
  return null;
}

Future<Weather?> weatherReport() async {
  final apiKey = dotenv.env['WEATHERAPI'].toString();
  WeatherFactory wf = WeatherFactory(apiKey);
  try {
    final location = await getlocation();
    if (location != null) {
      final lat = location['lat'];
      final lon = location['lon'];
      print("${lat}, ${lon}");
      Weather w = await wf.currentWeatherByLocation(lat!, lon!);
      return w;
    }
  } catch (e) {
    Exception("Error Fetching Weather: $e");
  }
  return null;
}
