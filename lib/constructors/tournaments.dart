import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/screens/Interaction/interaction_tournaments.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/images.dart';
import 'package:waytoturf/utils/sizes.dart';

class TournamentsTile extends StatelessWidget {
  final Map<String, dynamic> data;
  const TournamentsTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Card(
        color: MyColors.white,
        margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 8,
        child: SizedBox(
          height: 180,
          width: screenWidth*0.8,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16,bottom: 16,left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(5),
                          child: Image.asset(
                            data["image"],
                            height: 75,
                            width: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Hor(10),
                        SizedBox(
                          width: screenWidth*0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                data["name"],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.black,fontSize: screenWidth*0.03),
                              ),

                              Ver(5),

                              AutoSizeText(
                                data["location"],
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth*0.02,
                                    color: MyColors.darkGrey),
                              ),


                            ],
                          ),
                        ),
                      ],
                    ),
                        Ver(10),
                    AutoSizeText(
                          data["price"]+" - onwards",
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth*0.04,
                              fontWeight: FontWeight.w700,
                              color: MyColors.darkerGrey),
                        ),
                    Ver(10),
                    SizedBox(
                      width: screenWidth*0.7,
                      child: Row(
                        children: [
                          AutoSizeText(
                            data["teamCanJoin"],
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth*0.03,
                                color: MyColors.darkerGrey),
                          ),
                          Spacer(),
                          SizedBox(
                            width: screenWidth*0.3,
                            height: screenHeight*0.03,
                            child: ElevatedButton(
                              onPressed: () {
                              },
                              child: AutoSizeText("Book Now", style: GoogleFonts.poppins(
                                fontSize: screenWidth*0.01,
                                color:Colors.white,
                              )),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.appColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                  width: 6, // Height of the border
                  decoration: BoxDecoration(
                    color: MyColors.appColor, // Bottom border color
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                    ),
                  )),
            ],
          ),
        ));
  }
}
