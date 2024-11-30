import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:waytoturf/constructors/products.dart';
import 'package:waytoturf/constructors/profilepic.dart';
import 'package:waytoturf/constructors/textformfield.dart';
import 'package:waytoturf/constructors/tournaments.dart';
import 'package:waytoturf/screens/Interaction/interaction_events.dart';
import 'package:waytoturf/screens/Interaction/interaction_notifications.dart';
import 'package:waytoturf/screens/Interaction/interaction_products.dart';
import 'package:waytoturf/screens/Interaction/interaction_turfs.dart';
import 'package:waytoturf/screens/cities/cities.dart';
import 'package:waytoturf/screens/dashboard/dashboard_controller.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/images.dart';
import 'package:waytoturf/utils/sizes.dart';
import 'package:intl/intl.dart';

import '../../constructors/events.dart';
import '../../constructors/turfcard.dart';
import '../Interaction/interaction_profile_edit.dart';
import '../Interaction/interaction_tournaments.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final controller = Get.put(DashboardController());
  late final latestVersion;
  late final urlToDownload;
  int _selectedIndex = 0;
  bool isUpdateNow = false;

  String _statusMessage = "Checking for updates...";

  @override
  void initState() {
    // TODO: implement initState
    controller.userRegistered();
   _checkForUpdates();
   isUpdateNow ? _downloadAndInstall(urlToDownload):null;
    super.initState();
  }

  Future<void> _checkForUpdates() async {
    try {
      // Get current app version
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      int currentVersionCode = int.parse(packageInfo.buildNumber);

      // Fetch latest version info from server
      final response = await Dio().get('https://b05b24de-8d53-4e64-882f-6f3f898b4109.mock.pstmn.io/latest-version'); // Replace with your API
      final latestVersionCode = response.data['versionCode'];
      final downloadUrl = response.data['downloadUrl'];

      latestVersion = latestVersionCode;
      urlToDownload = downloadUrl;

      if (latestVersionCode > currentVersionCode) {
        _showUpdateDialog(downloadUrl);
      } else {
        setState(() {
          _statusMessage = "Your app is up-to-date.";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Failed to check for updates: $e";
      });
    }
  }


  Future<void> _downloadAndInstall(String url) async {
    setState(() {
      _statusMessage = "Preparing to download...";
    });

    try {
      // Use Downloads directory
      Directory downloadsDir = Directory('/storage/emulated/0/Download/Way To Turf/');
      String fileName = "Way to Turf_$latestVersion.apk";
      String filePath = "${downloadsDir.path}/$fileName";

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      // Check if the file already exists
      File apkFile = File(filePath);
      if (await apkFile.exists()) {
        setState(() {
          _statusMessage = "Open downloads and install the file";
        });
        _scheduleFileDeletion(apkFile); // Schedule deletion for the existing file
        _showInstallDialog(fileName, downloadsDir.path);
        return;
      }

      // File does not exist, proceed to download
      setState(() {
        _statusMessage = "Downloading update...";
      });

      // Download the APK file
      await Dio().download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _statusMessage = "Downloading: ${(received / total * 100).toStringAsFixed(0)}%";
            });
          }
        },
      );

      // File successfully downloaded, schedule deletion
      _scheduleFileDeletion(File(filePath));

      // Show dialog after download
      _showInstallDialog(fileName, downloadsDir.path);
    } catch (e) {
      setState(() {
        _statusMessage = "Failed to download or install update: $e";
      });
    }
  }

  void _scheduleFileDeletion(File apkFile) {
    Future.delayed(const Duration(hours: 4), () async {
      try {
        if (await apkFile.exists()) {
          await apkFile.delete();
          print("File ${apkFile.path} deleted after 4 hours.");
        }
      } catch (e) {
        print("Failed to delete file: $e");
      }
    });
  }


  void _showInstallDialog(String fileName, String filePath) {
    showDialog(
      context: context,
      barrierColor: MyColors.black.withOpacity(0.7),
      barrierDismissible: false, // Prevent dismissal
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.white,
          title: Text(
            "Update Downloaded",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "The update has been downloaded.",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                "File: $fileName",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Do you want to install the update now?",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                exit(0); // Close the app
              },
              child: Text(
                "Close Now",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                OpenFile.open(filePath); // Open the APK for installation
              },
              child: Text(
                "Install Now",
                style: GoogleFonts.poppins(fontSize: 14,color: MyColors.appColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(String downloadUrl) {
    showDialog(
      context: context,
      barrierColor: MyColors.black.withOpacity(0.7),
      barrierDismissible: false, // Prevent dismissal
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.white,
          title: Text(
            "Update Available",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            "A new version of the app is available. Do you want to update now?",
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => exit(0), // Close the app
              child: Text(
                "Close",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _downloadAndInstall(downloadUrl);
                setState(() {
                  isUpdateNow = true;
                });
              },
              child: Text(
                "Update Now",
                style: GoogleFonts.poppins(fontSize: 14,color: MyColors.appColor),
              ),
            ),
          ],
        );
      },
    );
  }


  int selectedIndex = 0;

  Widget buildIconButton(int index, IconData icon, String label) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          print(index);// Update the selected index on tap
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? MyColors.appColor : Colors.white,
            ),
            isSelected ? Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? MyColors.appColor : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ):Text(""),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight =
        MediaQuery.of(context).size.height; // Get screen height

    final city = controller.deviceStorage.read('city');

    final dateToday = DateFormat("d MMM").format(DateTime.now());

    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: isUpdateNow ? Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Update App",style: GoogleFonts.poppins(
          color: Colors.white,
        ),),centerTitle: true,backgroundColor: MyColors.appColor,),
        body: SafeArea(
          child: GestureDetector(

            child: Center(
              child: Text(_statusMessage),
            ),
          ),
        ),
      ):Scaffold(
        backgroundColor: MyColors.white,
        bottomNavigationBar: BottomAppBar(
          height: screenHeight * 0.0725,
          color: MyColors.appColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildIconButton(0, Icons.home_rounded, "Home"),
              buildIconButton(1, Icons.sports, "Sports"),
              buildIconButton(2, Icons.confirmation_num_outlined, "Tickets"),
              buildIconButton(3, Icons.shopping_bag_outlined, "Cart"),
              buildIconButton(4, Icons.chat, "Support"),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Divider(
              height: 1,
              thickness: 2,
              color: Colors.grey
                  .withOpacity(0.3), // Change color to suit your app's theme
            ),
          ),
          leadingWidth: screenWidth,
          toolbarHeight: screenHeight * 0.21,
          leading: Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            color: MyColors.white,
            child: Column(
              children: [
                Ver(screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: MyColors.black,
                      size: screenHeight * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const Cities());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(city,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () =>
                          Get.to(() => const InteractionNotificationsPage()),
                      child: Icon(
                        Icons.notifications_none_rounded,
                        color: MyColors.black,
                        size: screenHeight * 0.05,
                      ),
                    ),
                    Hor(20),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const InteractionProfileEdit());
                      },
                      child: ProfilePicture(
                          circleRadius: screenHeight * 0.03,
                          image: const AssetImage(MyImages.user)),
                    ),
                  ],
                ),
                Ver(30),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.5),
                      border:
                          Border.all(color: MyColors.darkerGrey, width: 2)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Textformfield(
                        isInputBorder: false,
                        keyboardType: TextInputType.text,
                        borderradius: MySizes.borderRadiusMd,
                        textCapitalization: TextCapitalization.sentences,
                        fontSize: 16,
                        textAlign: TextAlign.start,
                        prefixIcon: Icon(
                          Icons.search,
                          color: MyColors.darkerGrey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height:screenHeight*0.175, // Height of the carousel
                  autoPlay: true, // Enable auto-play
                  enlargeCenterPage: true, // Enlarge the current image
                  aspectRatio: 16 / 9,
                  viewportFraction: 1, // Fraction of the screen to occupy
                ),
                items: controller.imageUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: screenWidth * 0.925,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage(url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 5),
                child: Column(
                  children: [
                    Ver(20),
                    Row(
                      children: [
                        AutoSizeText(
                          "Available Venues",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                          fontSize: screenWidth*0.06),
                        ),
                        Spacer(),
                        Icon(
                          Icons.tune,
                          color: Colors.black,
                          size: 30,
                        ),
                        Hor(10),
                      ],
                    ),
                    Ver(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Date Selector Button
                        ElevatedButton(
                          onPressed: () {
                            // Add your date picker functionality here
                          },
                          child: Row(
                            children: [
                              AutoSizeText(dateToday,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: screenWidth*0.0275
                                  )),
                              Icon(
                                Icons.arrow_drop_down,
                                color: MyColors.white,
                                size: screenWidth*0.06,
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.appColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth*0.05, vertical: screenWidth*0.025),
                          ),
                        ),
                        Hor(5),
                        Text(
                          "|",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 30),
                        ),
                        Hor(5),
                        // Sports Icon List
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  List.generate(controller.sportsData.length, (index) {
                                final sport = controller.sportsData[index];
                                bool isSelected = index == _selectedIndex;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // Update selected index
                                      _selectedIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right:
                                            16.0), // Add spacing between icons
                                    child: CircleAvatar(
                                      radius: screenWidth*0.05,
                                      backgroundColor: isSelected
                                          ? MyColors.appColor
                                          : Colors.grey.withOpacity(0.1),
                                      child: Icon(sport['icon'],
                                          color: isSelected
                                              ? Colors.white
                                              : MyColors.appColor,
                                          size: screenWidth*0.08),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Ver(10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  children: controller.turfData
                      .map((data) {
                        return TurfCard(
                          data,
                          sportIcons: controller.sportIcons,
                        ); // Assuming TurfCard is your widget for displaying each item
                      })
                      .take(3)
                      .toList(),
                ),
              ),
              Ver(10),
              SizedBox(
                width: screenWidth * 0.35,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => InteractionTurfsPage(turfData: controller.turfData, sportIcons: controller.sportIcons,));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText("More Turf",
                          style: GoogleFonts.poppins(
                            color: Colors.white
                          )),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: MyColors.white,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.appColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              Ver(20),
              Divider(
                color: MyColors.grey.withOpacity(0.3),
                height: 1,
                thickness: 2,
              ),
              Ver(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    AutoSizeText(
                      "Near you Events",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth*0.06,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.to(() => InteractionEventsPage(data: controller.turfEventsData, sportIcons: controller.sportIcons,)),
                      child: AutoSizeText(
                        "View all",
                        style: GoogleFonts.poppins(
                            color: MyColors.appColor,
                            fontSize: screenWidth*0.05,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Ver(10),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: List.generate(3, (index){
                    return EventsTile(data: controller.turfEventsData[index], sportIcons:controller.sportIcons,);
                  }),
                )
                ),
              Ver(20),
              Divider(
                color: MyColors.grey.withOpacity(0.3),
                height: 1,
                thickness: 2,
              ),
              Ver(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    AutoSizeText(
                      "Products",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: screenWidth*0.06,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () =>
                          Get.to(() => InteractionProductsPage(data: controller.sportsProducts)),
                      child: AutoSizeText(
                        "View all",
                        style: GoogleFonts.poppins(
                            color: MyColors.appColor,
                            fontSize: screenWidth*0.05,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Ver(10),
              SizedBox(
                height: screenHeight*0.625,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),
                    itemBuilder: (context, index) {
                      return ProductsTile( data: controller.sportsProducts[index]);
                    },
                  ),
                ),
              ),
              Ver(20),
              Divider(
                color: MyColors.grey.withOpacity(0.3),
                height: 1,
                thickness: 2,
              ),
              Ver(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    AutoSizeText(
                      "New Upcoming Tournaments",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: screenWidth*0.045,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () =>
                          Get.to(() => InteractionTournamentsPage(data: controller.upComingTurfTournaments,)),
                      child: AutoSizeText(
                        "View all",
                        style: GoogleFonts.poppins(
                            color: MyColors.appColor,
                            fontSize: screenWidth*0.045,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              Ver(20),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(controller.upComingTurfTournaments.length, (index) {
                      return TournamentsTile(data: controller.upComingTurfTournaments[index]);
                    }),
                    // children: turfData.map((data) {
                    //   return TournamentsTile(data: data); // Assuming TurfCard is your widget for displaying each item
                    // }).take(3).toList(),
                  ),
                ),
              ),
              Ver(20),
              Divider(
                color: MyColors.grey.withOpacity(0.3),
                height: 1,
                thickness: 2,
              ),
              Ver(20)
            ]),
          ),
        ),
      ),
    );
  }
}
