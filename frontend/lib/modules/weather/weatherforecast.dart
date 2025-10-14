import 'package:alabaster/modules/weather/weatherapi.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'dart:async';

class forecastWidget extends StatefulWidget {
  const forecastWidget({super.key});

  @override
  State<forecastWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<forecastWidget> {
  static Weather? cachedWeather;
  static DateTime? lastFetchTime;

  late Future<Weather?> _forecastFuture;

  @override
  void initState() {
    super.initState();
    _forecastFuture = _getWeather();
  }

  Future<Weather?> _getWeather() async {
    // Check if we fetched less than 20 mins ago
    if (cachedWeather != null &&
        lastFetchTime != null &&
        DateTime.now().difference(lastFetchTime!) <
            const Duration(minutes: 20)) {
      return cachedWeather;
    }

    final data = await weatherReport();
    cachedWeather = data;
    lastFetchTime = DateTime.now();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerHeight = constraints.maxHeight;
        final containerWidth = constraints.maxWidth;
        return Container(
          height: containerHeight * 0.32,
          width: containerWidth * 0.485,
          decoration: BoxDecoration(
            color: Colors.lightBlue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 1000,
                    height: 1000,
                    child: Image.asset(
                      "assets/weather/morining_rain.gif",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                    future: _forecastFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "${snapshot.data!.temperature.toString().split(" ")[0]}°C",
                                      style: const TextStyle(
                                        fontSize: 300,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "\n${snapshot.data?.weatherDescription.toString().capitalize()}",
                                      style: TextStyle(fontSize: 100),
                                    ),
                                    TextSpan(
                                      text:
                                          "\nFeels like: ${snapshot.data?.tempFeelsLike.toString().split(" ")[0]}°C",
                                      style: TextStyle(fontSize: 100),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: Text('No data available'));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
