import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/screens/onboarding/onboarding.dart';
import 'package:waytoturf/utils/colors.dart';

class InteractionContinuePage extends StatelessWidget {
  const InteractionContinuePage({
    super.key, this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;  // Get screen width
    final screenHeight = MediaQuery.of(context).size.height; // Get screen height

    return SizedBox(
        width: screenWidth-40,
        child: TextButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.appColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
          child: AutoSizeText(
            "Continue",
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              fontWeight: FontWeight.w500,
              color: MyColors.white,
            ),
          ),
        ));
  }
}


