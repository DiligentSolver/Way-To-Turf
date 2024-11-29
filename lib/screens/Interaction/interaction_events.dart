import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/constructors/events.dart';

import '../../constructors/turfcard.dart';

class InteractionEventsPage extends StatelessWidget {
  const InteractionEventsPage({super.key, required this.data, required this.sportIcons});

  final List<Map<String, dynamic>> data;
  final Map<String, IconData> sportIcons;

  @override
  Widget build(BuildContext context) {



    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Upcoming Events",
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: GestureDetector(onTap: ()=>Get.back(),child: Icon(Icons.arrow_back_ios_new))
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: List.generate(data.length, (index){
                        return EventsTile(data: data[index], sportIcons: sportIcons,);
                      }),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
