import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/bars.dart';
import '../../dashboard/dashboard_homepage.dart';

class InteractionController extends GetxController {
  static InteractionController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController location = TextEditingController();
  
  var deviceStorage = GetStorage();
  
  void goToHome(bool toast,String message){
    if(formKey.currentState!.validate()) {
      Get.offAll(() => const HomePage());
      toast ? Loader.customToast(message: message) : null;
    }
  }


}
