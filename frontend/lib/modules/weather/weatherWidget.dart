import 'package:alabaster/modules/weather/weatherapi.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'dart:async';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Future<Weather?> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = weatherReport();

    Timer.periodic(const Duration(minutes: 20), (timer) {
      if (mounted) {
        setState(() {
          _weatherFuture = weatherReport();
        });
      }
    });
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

                  child: FutureBuilder<Weather?>(
                    future: _weatherFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final row1Data = ["Temperature:", "Humidity:", "Wind:"];

                        final row1Values = [
                          "${snapshot.data!.temperature.toString().split(" ")[0]}°C",
                          "${snapshot.data!.humidity}%",
                          "${snapshot.data!.windSpeed} km/h",
                        ];

                        final row2Data = ["Max:", "Min:", "Feels Like:"];

                        final row2values = [
                          "${snapshot.data!.tempMax.toString().split(" ")[0]}°C",
                          "${snapshot.data!.tempMin.toString().split(" ")[0]}°C",
                          "${snapshot.data!.tempFeelsLike.toString().split(" ")[0]}°C",
                        ];
                        return Container(
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // First Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(row1Data.length, (
                                      index,
                                    ) {
                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          padding: const EdgeInsets.all(8),
                                          height: containerHeight / 2.3,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.6,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${row1Data[index]}\n",
                                                      style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: row1Values[index],
                                                      style: TextStyle(
                                                        fontSize: 50,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),

                                  SizedBox(height: 8),
                                  // Second Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(row1Data.length, (
                                      index,
                                    ) {
                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          padding: const EdgeInsets.all(8),
                                          height: containerHeight / 2.3,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.6,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${row2Data[index]}\n",
                                                      style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: row2values[index],
                                                      style: TextStyle(
                                                        fontSize: 50,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'No Data Available',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
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
