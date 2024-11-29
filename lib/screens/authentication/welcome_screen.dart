import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/constructors/textformfield.dart';
import 'package:waytoturf/screens/Interaction/interaction_t&c.dart';
import 'package:waytoturf/screens/authentication/controller/otp_controller.dart';
import 'package:waytoturf/screens/authentication/otp_verification.dart';
import 'package:waytoturf/screens/cities/cities.dart';
import 'package:waytoturf/screens/dashboard/dashboard_homepage.dart';
import 'package:waytoturf/utils/bars.dart';
import 'package:waytoturf/utils/images.dart';
import 'package:waytoturf/utils/sizes.dart';
import 'package:waytoturf/utils/texts.dart';

import '../../utils/colors.dart';
import 'authentication_widgets/authentication_getOtp.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = Get.put(OtpController());

  bool isChecked = false;

  GlobalKey<FormState> mobnumkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final phoneNum = "+91${controller.mobnum.text}";

    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Opacity(
              opacity: 0.2,
              child: Image.asset(
                MyImages.backgroundImage,
                height: screenHeight,
                width: screenWidth,
                fit: BoxFit.cover,
              )),
          Column(
            children: [
              Expanded(flex: 8, child: Ver(10)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.w500,
                        color: MyColors.black,
                      ),
                      children: [
                        const TextSpan(
                          text: "Welcome to ",
                        ),
                        TextSpan(
                          text: "way to turf",
                          style: GoogleFonts.poppins(
                            color: MyColors.appColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                ),
              ),
              Ver(10),
              SizedBox(
                width: screenWidth * 0.6,
                child: Text(
                  "Please enter a 10-digit valid mobile number to receive OTP",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    color: MyColors.black,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              ),
              Ver(40),
              Expanded(
                flex: 10,
                child: SizedBox(
                  width: screenWidth - 80,
                  height: 80,
                  child: Form(
                    key: mobnumkey,
                    child: Textformfield(
                      onFieldSubmitted: (value) {
                        if(mobnumkey.currentState!.validate()&&isChecked) {
                          controller.getOtp(phoneNum);
                        }
                        if(isChecked==false){
                          Loader.customToast(message: "Please check T&C to continue");
                        }
                      },
                      controller: controller.mobnum,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      borderradius: 10,
                      textCapitalization: TextCapitalization.none,
                      isPhoneField: true,
                      prefixText: "  +91    |     ",
                      prefixIcon: const Icon(FontAwesomeIcons.phone),
                      fontSize: 16,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Text(
                "*Note:- This is a dummy app",
                style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.05, color: MyColors.darkerGrey),
              ),
              Ver(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = isChecked ? !isChecked : !isChecked;
                          });
                        },
                        child: Icon(
                          isChecked
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank_outlined,
                          color: MyColors.appColor,
                          size: 30,
                        )),
                    Hor(10),
                    GestureDetector(
                      onTap: () => Get.to(() => const TermsAndConditionsPage()),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: MyColors.black,
                          ),
                          children: [
                            const TextSpan(
                              text: "By proceeding you agree to the\n",
                            ),
                            TextSpan(
                              text: "Terms and Conditions",
                              style: GoogleFonts.poppins(
                                color: MyColors.appColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: GoogleFonts.poppins(
                                color: MyColors.appColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Ver(5),
              GetOtp(
                onPressed: () {
                  if (mobnumkey.currentState!.validate()&&isChecked) {
                    controller.getOtp(phoneNum);
                  }

                  if(isChecked==false){
                    Loader.customToast(message: "Please check T&C to continue");
                  }
                },
              ),
              Ver(30),
            ],
          )
        ]),
      ),
    );
  }
}
