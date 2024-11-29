import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/screens/Interaction/interaction_widgets/interaction_continue.dart';
import 'package:waytoturf/utils/bars.dart';
import 'package:waytoturf/utils/sizes.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';
import 'controller/interaction_controller.dart';
import 'interaction_profile_upate.dart';

class InteractionSelectSports extends StatefulWidget {
  const InteractionSelectSports({super.key});

  @override
  State<InteractionSelectSports> createState() => _InteractionSelectSportsState();
}

class _InteractionSelectSportsState extends State<InteractionSelectSports> {
  final List<Map<String, dynamic>> sports = [
    {"name": "Football", "icon": Icons.sports_soccer},
    {"name": "Cricket", "icon": Icons.sports_cricket},
    {"name": "Basketball", "icon": Icons.sports_basketball},
    {"name": "Badminton", "icon": FontAwesomeIcons.tableTennisPaddleBall},
    {"name": "Swimming", "icon": FontAwesomeIcons.personSwimming},
    {"name": "VolleyBall", "icon": Icons.sports_volleyball},
  ];

  final controller = Get.put(InteractionController());

  int? selectedSportIndex;

  var deviceStorage = GetStorage();

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
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(child: Ver(60)),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  AutoSizeText("Select your favourite sports",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontWeight: FontWeight.w500,
                        color: MyColors.black,
                        fontSize: screenWidth*0.0575,
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: sports.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = selectedSportIndex == index;
                    return GestureDetector(
                      onTap: () async {
                       deviceStorage.write("Fav_Sport", sports[index]['name']);
                        setState((){
                          selectedSportIndex = index; // Update selected index
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: screenWidth*0.15),
                        child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? MyColors.appColor : null,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  sports[index]["icon"],
                                  color: isSelected
                                      ? Colors.white
                                      : MyColors.appColor,size: screenWidth*0.1,
                                ),
                                Hor(8),
                                Text(sports[index]["name"],
                                    style: GoogleFonts.poppins(
                                      color: isSelected
                                          ? Colors.white
                                          : MyColors.appColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenWidth*0.05,
                                    )),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
             InteractionContinuePage(
              onPressed: (){
                if(selectedSportIndex!=null){
                  Get.to(const InteractionProfileUpdate());
                }
                else{
                  Loader.customToast(message: "Select to continue");
                }
              },
            ),
            Ver(30)
          ]),
        ]),
      ),
    );
  }
}
