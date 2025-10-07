import 'package:alabaster/modules/bottomleft.dart';
import 'package:alabaster/modules/middleleft.dart';
import 'package:alabaster/modules/topleft.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late PageController topleftController;
  late PageController middleleftController;
  late PageController bottomleftController;

  int topleftPage = 0;
  int middleleftpage = 0;
  int bottomleftPage = 0;

  List<Widget> topLeft(BuildContext context) => [clock1(context)];

  List<Widget> middleleft(BuildContext context) => [
    digital_clock1(context),
    digital_clock2(context),
  ];

  List<Widget> bottomleft(BuildContext context) => [date()];

  @override
  void initState() {
    super.initState();
    topleftController = PageController(initialPage: 1000);
    middleleftController = PageController(initialPage: 1000);
    bottomleftController = PageController(initialPage: 1000);
  }

  @override
  void dispose() {
    topleftController.dispose();
    middleleftController.dispose();
    bottomleftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topleftWidgets = topLeft(context);
    final middleleftWidgets = middleleft(context);
    final bottomleftWidgets = bottomleft(context);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              "assets/backgrounds/Rain.gif",
              fit: BoxFit.cover,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Left Widget
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.76,
                  width: MediaQuery.of(context).size.width * 0.5,
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

              // Middle Left Widget
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SizedBox(
                    child: PageView.builder(
                      controller: middleleftController,
                      onPageChanged: (index) {
                        setState(() {
                          middleleftpage = index % middleleftWidgets.length;
                        });
                      },
                      itemBuilder: (context, index) {
                        final circularIndex = index % middleleftWidgets.length;
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
                  child: SizedBox(
                    child: PageView.builder(
                      controller: bottomleftController,
                      onPageChanged: (index) {
                        setState(() {
                          bottomleftPage = index % bottomleftWidgets.length;
                        });
                      },
                      itemBuilder: (context, index) {
                        final circularIndex = index % bottomleftWidgets.length;
                        return bottomleftWidgets[circularIndex];
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
