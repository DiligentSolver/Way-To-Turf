import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/constructors/events.dart';
import 'package:waytoturf/constructors/tournaments.dart';

import '../../constructors/products.dart';

class InteractionProductsPage extends StatelessWidget {
  const InteractionProductsPage({super.key, required this.data});

  final List<Map<String,dynamic>> data;

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Products",
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
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),
                  itemBuilder: (context, index) {
                    return ProductsTile(data: data[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
