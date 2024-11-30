
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/utils/colors.dart';

class ConnectedPage extends StatefulWidget {
  const ConnectedPage({super.key});

  @override
  ConnectedPageState createState() => ConnectedPageState();
}

class ConnectedPageState extends State<ConnectedPage>{


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi,
                size: 100,
                color: MyColors.appColor,
              ),
              SizedBox(height: 20),
              Text(
                "Connected",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Make your interaction continue......",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
