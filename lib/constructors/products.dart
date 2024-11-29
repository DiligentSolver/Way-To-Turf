import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/images.dart';
import 'package:waytoturf/utils/sizes.dart';

class ProductsTile extends StatelessWidget {
  final Map<String, dynamic> data;

  const ProductsTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Card(
      color: MyColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
              data["image"],
                height: screenHeight*0.225,
                width: screenWidth*0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              data["productName"],
              maxLines: 2,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: MyColors.black,
                fontSize: screenWidth*0.025
              ),
            ),
          ),
          Container(
              height: 5,
              width: screenWidth*0.5,// Height of the border
              decoration: BoxDecoration(
                color: MyColors.appColor, // Bottom border color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),)),
        ],
      )
    );
  }
}
