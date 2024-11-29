import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waytoturf/screens/authentication/otp_verification.dart';
import 'package:waytoturf/screens/authentication/repository/authentication_repository.dart';
import 'package:waytoturf/screens/authentication/welcome_screen.dart';

import '../../cities/cities.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();
  final authController = Get.put(AuthenticationRepository(FirebaseAuth.instance));

  TextEditingController mobnum = TextEditingController();
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

    void getOtp(String phoneNumber) {
          authController.sendOtp(phoneNumber);
        Get.to(() => const OtpVerification());
  }

  void verifyOtp(String smsCode){
      authController.verifyOtp(smsCode);
      Get.offAll(() => const Cities());
  }

}
