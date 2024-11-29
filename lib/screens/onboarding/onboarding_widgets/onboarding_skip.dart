import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/utils/colors.dart';

import '../../../utils/sizes.dart';
import '../controller/onboardingcontroller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Ver(10),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 16.0),
          child: GestureDetector(
            onTap: () => OnBoardingController.instance.skipPage(),
            child: AutoSizeText(
              "Skip",
              maxLines: 1,
              style: GoogleFonts.poppins(
                  color: MyColors.appColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
