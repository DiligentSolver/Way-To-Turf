import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/constructors/textformfield.dart';
import 'package:waytoturf/utils/images.dart';
import 'package:waytoturf/utils/sizes.dart';
import 'package:waytoturf/utils/texts.dart';

import '../../utils/colors.dart';
import 'authentication_widgets/authentication_verifyOtp.dart';
import 'controller/otp_controller.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  final controller = Get.put(OtpController());
  GlobalKey<FormState> otpKey = GlobalKey<FormState>();

  late Timer timer;
  int secondsRemaining = 60;
  bool isResendEnabled = false;

  @override
  void initState() {

      for (int i = 0; i < controller.focusNodes.length; i++) {
        controller.focusNodes[i].addListener(() {
          if (controller.focusNodes[i].hasFocus) {
            // Ensure keyboard stays active during focus
            controller.controllers[i].selection = TextSelection.collapsed(
              offset: controller.controllers[i].text.length,
            );
          }
        });
      }

    startTimer();
    super.initState();
  }

  void startTimer() {
    setState(() {
      secondsRemaining = 60;
      isResendEnabled = false;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          isResendEnabled = true;
        });
        timer.cancel();
      }
    });

  }

  void resendOTP() {
    if (isResendEnabled) {
      final phoneNum = "+91${controller.mobnum.text}";
      controller.getOtp(phoneNum);
      startTimer();
    }
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 3) {
        Future.delayed(Duration.zero, () {
          controller.focusNodes[index + 1].requestFocus();
        });
      }
    } else {
      if (index > 0) {
        Future.delayed(Duration.zero, () {
          controller.focusNodes[index - 1].requestFocus();
        });
      }
    }
  }





  @override
  Widget build(BuildContext context) {

    final otp = controller.controllers.map((controller) => controller.text).join();

    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height
    return Scaffold(
      body: SafeArea(
        child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    MyImages.backgroundImage,
                    height: screenHeight,
                    width: screenWidth,
                    fit: BoxFit.cover,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Ver(10)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Mobile Number",
                        style: GoogleFonts.poppins(
                          color: MyColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.09,
                    )
                  )),
                  Ver(10),
                  Text(
                    "OTP has been sent to you on your mobile number, please enter it below",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                      color: MyColors.black,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  Ver(50),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: Text(
                      "Enter sample OTP { 8 4 6 2 } for login",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        color: MyColors.redLightShade,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Ver(20),
                  Form(
                    key: otpKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                        List.generate(
                                4,(index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Hor(10),
                                      SizedBox(
                                        width: screenWidth*0.150,
                                        child: Textformfield(
                                          focusNode: controller.focusNodes[index],
                                          controller: controller.controllers[index],
                                          onChanged: (value) => onChanged(value, index),
                                          isOtpField: true,
                                          maxLength: 1,
                                          keyboardType: TextInputType.number,
                                          borderradius: 10,
                                          textCapitalization: TextCapitalization.none,
                                          textInputAction: TextInputAction.next, fontSize: 20, textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Hor(10)
                                    ],
                                  );
                        }),
                    ),
                  ),
                  Expanded(child: Ver(10)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
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
                            text: "Don't receive OTP?\n",
                          ),
                          isResendEnabled ? TextSpan(
                            text: "Resend OTP",
                            recognizer: TapGestureRecognizer()..onTap=(){
                              resendOTP();
                            },
                            style: GoogleFonts.poppins(
                              color: MyColors.appColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ):TextSpan(
                            text: "Resend in ",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: MyColors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "${secondsRemaining.toString()}s",
                                style: GoogleFonts.poppins(
                                  color: MyColors.appColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]
                          ),
                        ],
                      ),
                    ),
                  ),
                  Ver(5),
                  VerifyOtp(onPressed: (){
            if(otpKey.currentState!.validate() && controller.authController.isOTPMatched) {
                    controller.verifyOtp(otp);}
                  }),
                  Ver(30),
                ],
              )
            ]),
      ),
      backgroundColor: Colors.white,
    );
  }
}
