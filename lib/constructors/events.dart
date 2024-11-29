import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/images.dart';
import 'package:waytoturf/utils/sizes.dart';

class EventsTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, IconData> sportIcons;

  const EventsTile({super.key, required this.data, required this.sportIcons});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Card(
      color: MyColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 4,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
            child: Image.asset(
            data["image"],
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                data["name"],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth*0.04,
                    color: MyColors.black),
              ),
                  Ver(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(sportIcons[data["sport"]],size: screenWidth*0.03,),
                          Hor(5),
                          AutoSizeText(
                            data["sport"],
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth*0.03,
                                fontWeight: FontWeight.w500,
                                color: MyColors.darkGrey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: MyColors.darkGrey,
                            size: screenWidth*0.03,
                          ),
                          AutoSizeText(
                            data["distance"] + " away",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth*0.02,
                                color: MyColors.darkGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Ver(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        data["date"],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: screenWidth*0.03,
                            color: MyColors.darkGrey),
                      ),
                      AutoSizeText(
                        data["price"],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth*0.02,
                            color: MyColors.darkerGrey),
                      ),
                    ],
                  ),
                  Ver(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Booking Closes On",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,fontSize: screenWidth*0.03,
                            color: MyColors.darkGrey),
                      ),
                      AutoSizeText(
                        data["bookingEnd"],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: screenWidth*0.02,
                            color: MyColors.darkGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
              height: 100,
              width: 5,// Height of the border
              decoration: BoxDecoration(
                color: MyColors.appColor, // Bottom border color
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                ),)),
        ],
      )
    );
  }
}
