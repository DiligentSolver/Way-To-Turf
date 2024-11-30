import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waytoturf/screens/authentication/welcome_screen.dart';
import 'package:waytoturf/screens/dashboard/dashboard_homepage.dart';
import 'package:waytoturf/screens/onboarding/onboarding.dart';

import '../../../utils/bars.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  AuthenticationRepository(this._auth);

  final FirebaseAuth _auth;
  final User? authUser = FirebaseAuth.instance.currentUser;
  final String? email = FirebaseAuth.instance.currentUser?.email;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final Rx<User?> firebaseUser;
  final deviceStorage = GetStorage();
  String _verificationId = '';
  bool isOtpSent = false;
  bool isOTPMatched = false;


  @override
  Future<void> onReady() async {


    firebaseUser = Rx<User?>(_auth.currentUser);
    ever(firebaseUser, (callback) {
      firebaseUser.bindStream(_auth.authStateChanges());
      if (callback == null) {
        _auth.signOut();
      }
    });

    Timer(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
      checkUser();
      super.onReady();
    });
  }

  void sendOtp(String? phoneNumber) async {
    Loader.customToast(message: "Otp Sent");
    try{
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Loader.successSnackBar(title: "Verification Completed!");
        },
        verificationFailed: (FirebaseAuthException e) {
          Loader.errorSnackBar(title: "Sorry",message: "No Otp in spark plan(Firebase)");
        },
        codeSent: (verificationId, resendToken) {
            isOtpSent = true;
            _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        });} catch(e){
      Loader.errorSnackBar(title: "Sorry!",message: e);
    }
  }

  reqPermission() async {
    await Permission.storage.request();
  }

   verifyOtp (String smsCode) {
  //   try{
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: smsCode);
  //
  //   UserCredential userCredential = await _auth.signInWithCredential(credential);
  //
  //   Loader.successSnackBar(title: "Hurray!", message: "SignUp Successful!");
  // }catch (e){
  //     Loader.errorSnackBar(title: "Sorry!", message: e);
  // }
    if(smsCode=="8462"){
      Loader.successSnackBar(title: "Hurray!", message: "SignUp Successful!");
      isOTPMatched = true;
    }else{
      Loader.errorSnackBar(title: "Sorry!", message: "Otp not match");
      isOTPMatched = false;
    }

  }

  checkUser() async {
    try {
      deviceStorage.read('IsFirstTime')
          ? const Onboarding()
          : deviceStorage.read('userRegistered') ? const HomePage() : const WelcomeScreen();
      } catch (e) {
      Loader.errorSnackBar(title: 'Sorry', message: e);
    }
  }
}
