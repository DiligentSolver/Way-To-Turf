import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:waytoturf/utils/colors.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.home});

  final Widget home;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool isConnected = true;

  Future<void> checkConnection() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    setState(() {}); // Rebuild UI when connection status changes
    InternetConnectionChecker().onStatusChange.listen((status) {
      setState(() {
        isConnected = status == InternetConnectionStatus.connected;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: isConnected ? widget.home : NoInternetPage());
  }
}

class NoInternetPage extends StatefulWidget {
  const NoInternetPage({super.key});

  @override
  NoInternetPageState createState() => NoInternetPageState();
}

class NoInternetPageState extends State<NoInternetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: -0.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: const Icon(
                    Icons.wifi_off,
                    size: 100,
                    color: Colors.redAccent,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              "No Internet Connection",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please check your network settings",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
