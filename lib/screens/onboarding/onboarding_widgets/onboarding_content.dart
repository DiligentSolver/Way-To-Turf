import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/utils/colors.dart';

import '../../../utils/sizes.dart';

class OnboardingContent {
  final String image, title, description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;  // Get screen width
    final screenHeight = MediaQuery.of(context).size.height; // Get screen height
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Animate(
          effects: const [
            SlideEffect(
                duration: Duration(milliseconds: 500),
                curve: Curves.slowMiddle,
                begin: Offset(0, 0),
                end: Offset(0, 0)),
            FadeEffect()
          ],
          child: Image(
            fit: BoxFit.contain,
              width: screenWidth-30,
              height: screenHeight*0.5,
              image: AssetImage(image),
            ),
        ),
        SingleChildScrollView(
          child: Animate(
            effects: const [
              FadeEffect(
                curve: Curves.linear,
                delay: Duration(milliseconds: 300),
              )
            ],
            child: SizedBox(
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        color: MyColors.appColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),),
                    Ver(10),
                    SizedBox(
                      width: screenWidth*0.625,
                      child: Text(
                        description,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: MyColors.appColor,
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ),
      ],
    );
  }
}
