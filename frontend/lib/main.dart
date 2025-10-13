import 'dart:io';

import 'package:alabaster/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  tz.initializeTimeZones();

  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(fullScreen: true);

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  String envPath = '${Directory.current.path}/.env';
  await dotenv.load(fileName: envPath);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
