
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/constructors/textformfield.dart';
import 'package:waytoturf/screens/cities/cities.dart';
import 'package:waytoturf/screens/dashboard/dashboard_homepage.dart';
import 'package:waytoturf/utils/bars.dart';
import 'package:waytoturf/utils/sizes.dart';

import '../../constructors/profilepic.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import 'controller/interaction_controller.dart';
import 'interaction_widgets/interaction_continue.dart';

class InteractionProfileUpdate extends StatefulWidget {
  const InteractionProfileUpdate({super.key});

  @override
  State<InteractionProfileUpdate> createState() => _InteractionProfileUpdateState();
}

class _InteractionProfileUpdateState extends State<InteractionProfileUpdate> {
  final controller = Get.put(InteractionController());

  final List<Map<String, dynamic>> residence = [
    {"name": "Home", "icon": Icons.home},
    {"name": "Work", "icon": Icons.work},
  ];

  int residenceIndex=-1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(alignment: Alignment.center, children: [
          Opacity(
              opacity: 0.2,
              child: Image.asset(
                MyImages.backgroundImage,
                height: screenHeight,
                width: screenWidth,
                fit: BoxFit.cover,
              )),
          ListView(
            children: [
              Ver(screenHeight*0.025),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ProfilePicture(circleRadius: screenWidth*0.15, image: const AssetImage(MyImages.user),isEditable: true,),
                Ver(screenHeight*0.025),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Form(
                  key:controller.formKey,
                  child: Column(
                    children: [
                      Textformfield(
                        controller: controller.name,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(Icons.person),
                          hintText: "First Name",
                          borderradius: 10,
                          textCapitalization: TextCapitalization.words,
                          isNameField: true,
                          maxLength: 32,
                          textInputAction: TextInputAction.next,
                          fontSize: 14,
                          textAlign: TextAlign.start),
                      Ver(screenHeight*0.03),
                      Textformfield(
                        controller: controller.lastname,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(Icons.person),
                          hintText: "Last Name",
                          borderradius: 10,
                          textCapitalization: TextCapitalization.words,
                          isNameField: true,
                          maxLength: 32,
                          textInputAction: TextInputAction.next,
                          fontSize: 14,
                          textAlign: TextAlign.start),
                      Ver(screenHeight*0.03),
                      Textformfield(
                        controller: controller.email,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(Icons.email),
                          hintText: "Enter Email Id",
                          borderradius: 10,
                          textCapitalization: TextCapitalization.words,
                          isEmailField: true,
                          maxLength: 64,
                          textInputAction: TextInputAction.next,
                          fontSize: 14,
                          textAlign: TextAlign.start),
                      Ver(screenHeight*0.03),
                      Textformfield(
                        controller: controller.dob,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(Icons.cake),
                          suffixIcon: Icon(Icons.calendar_month,color: Colors.black,),
                          hintText: "Select your DOB",
                          borderradius: 10,
                          textCapitalization: TextCapitalization.words,
                          isDOBField: true,
                          textInputAction: TextInputAction.next,
                          fontSize: 14,
                          textAlign: TextAlign.start),
                      Ver(screenHeight*0.03),
                      Textformfield(
                        controller: controller.gender,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(Icons.supervised_user_circle_sharp),
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                          hintText: "Select your Gender",
                          borderradius: 10,
                          textCapitalization: TextCapitalization.words,
                          isGenderField: true,
                          textInputAction: TextInputAction.next,
                          fontSize: 14,
                          textAlign: TextAlign.start),
                      Ver(screenHeight*0.03),
                      Textformfield(
                        controller: controller.location,
                          keyboardType: TextInputType.text,
                          isLocationField: true,
                          prefixIcon: Icon(Icons.location_on),
                          hintText: "House No./Building Name/Colony/City",
                          borderradius: 10,
                          textCapitalization: TextCapitalization.words,
                          maxLength: 64,
                          textInputAction: TextInputAction.done,
                          fontSize: 14,
                          textAlign: TextAlign.start),
                      Ver(screenHeight*0.03),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth*0.6,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: residence.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 4,
                          ),
                          itemBuilder: (context, index) {
                            final isSelected = residenceIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  residenceIndex = index;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected ? MyColors.appColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: MyColors.appColor,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      residence[index]["icon"],
                                      size: 16,
                                      color: isSelected ? Colors.white : MyColors.appColor,
                                    ),
                                    Hor(8),
                                    Text(
                                      residence[index]["name"],
                                      style: GoogleFonts.poppins(
                                        color: isSelected ? Colors.white : MyColors.appColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                      Ver(screenHeight*0.05),
                      InteractionContinuePage(
                        onPressed: () {
                          if(residenceIndex!=-1){
                         controller.goToHome(false, "");
                          }
                          else{
                            Loader.customToast(message: "Select Residence to continue");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ]),
        ]),
      ),
    );
  }

}
