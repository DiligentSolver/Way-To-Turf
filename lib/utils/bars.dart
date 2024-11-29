import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class Loader {
  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.yellow,
        ));
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: MyColors.appColor,
        backgroundColor: Colors.yellow,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red));
  }

  static successSnackBar({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: MyColors.appColor,
        backgroundColor: MyColors.greenShade,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: Icon(
          Icons.check_circle,
          color: MyColors.appColor,
        ));
  }

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      padding: const EdgeInsets.only(bottom: 125),
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: MyColors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: MyColors.black.withOpacity(0.7),
          ),
          child: Center(
              child: Text(message,
                style: GoogleFonts.poppins(
                  color: MyColors.white,
                  fontWeight: FontWeight.w500,
                ),),
        ))));
  }
}
