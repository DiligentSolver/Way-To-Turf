import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/utils/colors.dart';

import '../controller/onboardingcontroller.dart';

class OnBoardingGetStarted extends StatelessWidget {
  const OnBoardingGetStarted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;  // Get screen width
    final screenHeight = MediaQuery.of(context).size.height; // Get screen height
    return SizedBox(
        width: screenWidth-40,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.getStarted(),
          style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          child: AutoSizeText(
            "Get Started",

            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              fontWeight: FontWeight.w500,
              color: MyColors.white,
            ),
          ),
        ));
  }
}

//onPressed: () => OnBoardingController.instance.nextPage(),
