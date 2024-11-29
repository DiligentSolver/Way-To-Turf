import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:waytoturf/utils/colors.dart';
import '../controller/onboardingcontroller.dart';
import '../onboarding.dart';
import 'onboarding_content.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SmoothPageIndicator(
                  count: Onboarding.onboardData.length,
                  controller: controller.pageController,
                  onDotClicked: controller.dotNavigationClick,
                  effect: CustomizableEffect(
                    spacing: 4.0,
                      dotDecoration: DotDecoration(
                        height: 6,
                        width: 6,
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.transparent,
                        dotBorder: DotBorder(
                          color: MyColors.appColor
                        )
                      ),
                      activeDotDecoration: DotDecoration(
                          height: 8,
                          width: 20,
                          borderRadius: BorderRadius.circular(6),
                          color: MyColors.appColor
                      ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
