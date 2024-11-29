import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:waytoturf/screens/onboarding/onboarding_widgets/onboarding_nextpage.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/sizes.dart';
import '../../utils/texts.dart';
import 'controller/onboardingcontroller.dart';
import 'onboarding_widgets/onboarding_content.dart';
import 'onboarding_widgets/onboarding_dotnavigation.dart';
import 'onboarding_widgets/onboarding_getstarted.dart';
import 'onboarding_widgets/onboarding_skip.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  static OnBoardingController controller = Get.put(OnBoardingController());
  static List<OnboardingContent> onboardData = [
    OnboardingContent(
      image: MyImages.onBoardingPage1,
      title: MyTexts.onBoardingoneTitle,
      description: MyTexts.onBoardingooneDesc,
    ),
    OnboardingContent(
      image: MyImages.onBoardingPage2,
      title: MyTexts.onBoardingtwoTitle,
      description: MyTexts.onBoardingtwoDesc,
    ),
    OnboardingContent(
      image: MyImages.onBoardingPage3,
      title: MyTexts.onBoardingthreeTitle,
      description: MyTexts.onBoardingthreeDesc,
    ),
  ];

  @override
  State<Onboarding> createState() => _OnboardingState();
}

bool isLastPage = false;

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Skip Button
            Expanded(child: isLastPage ? const SizedBox() : const OnBoardingSkip()),
            
            ///Horizontal Scrollable Pages
            Expanded(
              flex: 16,
              child: PageView.builder(
                  itemCount: Onboarding.onboardData.length,
                  controller: Onboarding.controller.pageController,
                  onPageChanged: (index) {
                    Onboarding.controller.updatePageIndicator;
                    setState(() {
                      isLastPage =
                          index == Onboarding.onboardData.length - 1;
                    });
                  },
                  itemBuilder: (context, index) => OnBoardingContent(
                      image: Onboarding.onboardData[index].image,
                      title: Onboarding.onboardData[index].title,
                      description:
                      Onboarding.onboardData[index].description)),
            ),
            
            /// Dot Navigation SmoothPageIndicator
            const Expanded(child: OnBoardingDotNavigation()),
            
            /// Circular Button
            isLastPage
                ? const OnBoardingGetStarted()
                : const OnBoardingNextPage(),
            Ver(20)
          ],
        ),
      ),
    );
  }
}
