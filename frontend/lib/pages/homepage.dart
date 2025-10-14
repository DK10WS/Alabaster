import 'dart:async';

import 'package:alabaster/modules/bottomleft.dart';
import 'package:alabaster/modules/fourthWidget.dart';
import 'package:alabaster/modules/middleleft.dart';
import 'package:alabaster/modules/topleft.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late PageController topleftController;
  late PageController middleleftController;
  late PageController bottomleftController;
  late PageController toprightController;
  Timer? _autoRotateTimer;

  int topleftPage = 0;
  int middleleftpage = 0;
  int bottomleftPage = 0;
  int toprightPage = 0;

  List<Widget> topLeft(BuildContext context) => [clock1(context)];

  List<Widget> middleleft(BuildContext context) => [
    digital_clock1(context),
    digital_clock2(context),
  ];

  List<Widget> bottomleft(BuildContext context) => [date()];
  List<Widget> topright(BuildContext context) => [forecast(), weather()];

  @override
  void initState() {
    super.initState();
    topleftController = PageController(initialPage: 1000);
    middleleftController = PageController(initialPage: 1000);
    bottomleftController = PageController(initialPage: 1000);
    toprightController = PageController(initialPage: 1000);

    _autoRotateTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (toprightController.hasClients) {
        final nextPage = (toprightController.page?.toInt() ?? 0) + 1;
        toprightController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoRotateTimer?.cancel();
    topleftController.dispose();
    middleleftController.dispose();
    bottomleftController.dispose();
    toprightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topleftWidgets = topLeft(context);
    final middleleftWidgets = middleleft(context);
    final bottomleftWidgets = bottomleft(context);
    final toprightWidget = topright(context);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/backgrounds/Rain.gif",
              fit: BoxFit.cover,
            ),
          ),

          Row(
            children: [
              // Left Row
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Left Widget
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.76,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: PageView.builder(
                          controller: topleftController,
                          onPageChanged: (index) {
                            setState(() {
                              topleftPage = index % topleftWidgets.length;
                            });
                          },
                          itemBuilder: (context, index) {
                            final circularIndex = index % topleftWidgets.length;
                            return topleftWidgets[circularIndex];
                          },
                        ),
                      ),
                    ),
                  ),

                  // Middle Left Widget
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: PageView.builder(
                          controller: middleleftController,
                          onPageChanged: (index) {
                            setState(() {
                              middleleftpage = index % middleleftWidgets.length;
                            });
                          },
                          itemBuilder: (context, index) {
                            final circularIndex =
                                index % middleleftWidgets.length;
                            return middleleftWidgets[circularIndex];
                          },
                        ),
                      ),
                    ),
                  ),

                  // Bottom Left Widget
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: PageView.builder(
                          controller: bottomleftController,
                          onPageChanged: (index) {
                            setState(() {
                              bottomleftPage = index % bottomleftWidgets.length;
                            });
                          },
                          itemBuilder: (context, index) {
                            final circularIndex =
                                index % bottomleftWidgets.length;
                            return bottomleftWidgets[circularIndex];
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  // Top Right
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.32,
                      width: MediaQuery.of(context).size.width * 0.485,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: PageView.builder(
                          controller: toprightController,
                          onPageChanged: (index) {
                            setState(() {
                              bottomleftPage = index % toprightWidget.length;
                            });
                          },
                          itemBuilder: (context, index) {
                            final circularIndex = index % toprightWidget.length;
                            return toprightWidget[circularIndex];
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.32,
                      width: MediaQuery.of(context).size.width * 0.485,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.32,
                      width: MediaQuery.of(context).size.width * 0.485,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
