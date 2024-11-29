import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waytoturf/firebase_options.dart';
import 'package:waytoturf/screens/authentication/repository/authentication_repository.dart';
import 'package:waytoturf/screens/authentication/welcome_screen.dart';
import 'package:waytoturf/screens/dashboard/dashboard_homepage.dart';
import 'package:waytoturf/screens/onboarding/onboarding.dart';
import 'package:waytoturf/utils/device_utility.dart';

import 'myapp.dart';

Future<void> main() async {
  /// GetX Local Storage
  await GetStorage.init();
  var deviceStorage = GetStorage();
  deviceStorage.writeIfNull('IsFirstTime', true);
  deviceStorage.writeIfNull('userRegistered', false);

  final isFirstTime = deviceStorage.read('IsFirstTime');
  final userRegistered = deviceStorage.read('userRegistered');

  /// Widgets Binding
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    /// Await Splash until either items load
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// --Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
          (value) => Get.put(AuthenticationRepository(FirebaseAuth.instance)));

  /// --Initialize Authentication
  MyAppDeviceUtils.setPreferredOrientations(

      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp(
    home: isFirstTime
        ? const Onboarding()
        : userRegistered ? const HomePage() : const WelcomeScreen(),
  ));
}
