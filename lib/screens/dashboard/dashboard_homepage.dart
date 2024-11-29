import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/constructors/products.dart';
import 'package:waytoturf/constructors/profilepic.dart';
import 'package:waytoturf/constructors/textformfield.dart';
import 'package:waytoturf/constructors/tournaments.dart';
import 'package:waytoturf/screens/Interaction/interaction_events.dart';
import 'package:waytoturf/screens/Interaction/interaction_notifications.dart';
import 'package:waytoturf/screens/Interaction/interaction_products.dart';
import 'package:waytoturf/screens/Interaction/interaction_turfs.dart';
import 'package:waytoturf/screens/cities/cities.dart';
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
  var deviceStorage = GetStorage();

  final List<String> imageUrls = [
    MyImages.events,
    MyImages.discount,
    MyImages.refer,
    MyImages.coach,
    MyImages.champion
  ];

  final List<Map<String, dynamic>> sportsData = [
    {"name": "Football", "icon": Icons.sports_soccer},
    {"name": "Cricket", "icon": Icons.sports_cricket},
    {"name": "Basketball", "icon": Icons.sports_basketball},
    {"name": "Badminton", "icon": FontAwesomeIcons.tableTennisPaddleBall},
    {"name": "Swimming", "icon": FontAwesomeIcons.personSwimming},
    {"name": "VolleyBall", "icon": Icons.sports_volleyball},
  ];

  final Map<String, IconData> sportIcons = {
    "Cricket": Icons.sports_cricket,
    "Football": Icons.sports_soccer,
    "Badminton": Icons.sports_tennis,
    "Volleyball" : Icons.sports_volleyball,
    "Basketball" : Icons.sports_basketball,
    "Swimming" : FontAwesomeIcons.personSwimming,

    // Add more sports here as needed
  };
  final List<Map<String, dynamic>> turfEventsData = [
    {
      "image": MyImages.sprintandsmash, // Replace with actual image URL
      "name": "Sprint and Smash Turf",
      "distance": "2 Km",
      "price": "₹ 2999",
      "date": "Dec 05-08",
      "sport": "Cricket",
      "bookingEnd": "03 Dec '24"
    },
    {
      "image": MyImages.indorearena, // Replace with actual image URL
      "name": "Indore Arena",
      "distance": "3.5 Km",
      "price": "₹ 1999",
      "date": "Dec 10-12",
      "sport": "Badminton",
      "bookingEnd": "08 Dec '24"
    },
    {
      "image": MyImages.royalsports, // Replace with actual image URL
      "name": "Royal Sports Club",
      "distance": "5 Km",
      "price": "₹ 1499",
      "date": "Dec 15-18",
      "sport": "Football",
      "bookingEnd": "13 Dec '24"
    },
    {
      "image": MyImages.galaxysports, // Replace with actual image URL
      "name": "Galaxy Sports Complex",
      "distance": "1.2 Km",
      "price": "₹ 999",
      "date": "Dec 20-22",
      "sport": "Basketball",
      "bookingEnd": "18 Dec '24"
    },
    {
      "image": MyImages.victorGrounds, // Replace with actual image URL
      "name": "Victory Grounds",
      "distance": "4 Km",
      "price": "₹ 2499",
      "date": "Dec 25-28",
      "sport": "Volleyball",
      "bookingEnd": "23 Dec '24"
    },
  ];

  final List<Map<String, dynamic>> turfData = [
    {
      "discount": "10% OFF",
      "image": MyImages.badminton, // Replace with actual image URL
      "name": "Victory Sports Arena",
      "location": "Near Rajwada Palace, Indore",
      "distance": "3.5 Km",
      "price": "₹ 1999",
      "rating": "4.6",
      "reviews": "120",
      "sports": ["Badminton", "Volleyball"]
    },
    {
      "discount": "30% OFF",
      "image": MyImages.basketball, // Replace with actual image URL
      "name": "ProKick Turf",
      "location": "Near Bhawarkua Square, Indore",
      "distance": "1.8 Km",
      "price": "₹ 2499",
      "rating": "4.4",
      "reviews": "89",
      "sports": ["Football", "Basketball"]
    },
    {
      "discount": "15% OFF",
      "image": MyImages.swimming, // Replace with actual image URL
      "name": "Green Valley Turf",
      "location": "Near Choithram Hospital, AB Road, Indore",
      "distance": "5 Km",
      "price": "₹ 2799",
      "rating": "4.2",
      "reviews": "76",
      "sports": ["Swimming", "Volleyball"]
    },
    {
      "discount": "20% OFF",
      "image": MyImages.cricket1, // Replace with actual image URL
      "name": "Galaxy Sports Arena",
      "location": "Near Khajrana Ganesh Temple, Indore",
      "distance": "2.5 Km",
      "price": "₹ 3099",
      "rating": "4.5",
      "reviews": "105",
      "sports": ["Basketball", "Cricket"]
    },
    {
      "discount": "35% OFF",
      "image": MyImages.football, // Replace with actual image URL
      "name": "ArenaX Sports Hub",
      "location": "Near Rajendra Nagar, Indore",
      "distance": "3 Km",
      "price": "₹ 2399",
      "rating": "4.7",
      "reviews": "150",
      "sports": ["Football", "Swimming"]
    },
  ];

  final List<Map<String, dynamic>> upComingTurfTournaments = [
    {
      "name": "Indore Premier League",
      "image": MyImages.indorepremiere,
      "location": "Vijay Nagar, Indore",
      "price": "₹ 5000",
      "teamCanJoin": "8 Teams",
    },
    {
      "name": "Smash Badminton Tournament",
      "image": MyImages.smashbadminton,
      "location": "Near Palasia Square, Indore",
      "price": "₹ 3000",
      "teamCanJoin": "16 Teams",
    },
    {
      "name": "Hoop Warriors Championship",
      "image": MyImages.hoopwarriors,
      "location": "Rajwada, Indore",
      "price": "₹ 4500",
      "teamCanJoin": "10 Teams",
    },
    {
      "name": "Ace Volleyball Cup",
      "image": MyImages.acevolleyball,
      "location": "MG Road, Indore",
      "price": "₹ 3500",
      "teamCanJoin": "12 Teams",
    },
    {
      "name": "Football Kings League",
      "image": MyImages.footballkingsleague,
      "location": "AB Road, Indore",
      "price": "₹ 6000",
      "teamCanJoin": "6 Teams",
    },
  ];

  final List<Map<String, dynamic>> sportsProducts = [
    {
      "productName": "Pro Cricket Bat - Lightweight",
      "image": MyImages.cricketbat,
    },
    {
      "productName": "Dribble Pro Basketball - Indoor/Outdoor",
      "image": MyImages.basketball_p,
    },
    {
      "productName": "Smash Badminton Racket - Carbon Fiber",
      "image": MyImages.bdracket,
    },
    {
      "productName": "Viper Volleyball - Waterproof",
      "image": MyImages.volleyball,
    },
    {
      "productName": "ProFit Running Shoes - Breathable Design",
      "image": MyImages.shoes,
    },
    {
      "productName": "Speedy Tennis Ball - Pack of 6",
      "image": MyImages.tennis,
    },
    {
      "productName": "X-Trail Trekking Pole - Adjustable",
      "image": MyImages.trecking,
    },
    {
      "productName": "Stamina Jump Rope - Weighted Handles",
      "image": MyImages.rope,
    },
  ];


  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    userRegistered();
    super.initState();
  }

  void userRegistered() async {
    deviceStorage.write('userRegistered', true);
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
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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

    final city = deviceStorage.read('city');

    final dateToday = DateFormat("d MMM").format(DateTime.now());

    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Scaffold(
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
                items: imageUrls.map((url) {
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
                                  List.generate(sportsData.length, (index) {
                                final sport = sportsData[index];
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
                  children: turfData
                      .map((data) {
                        return TurfCard(
                          data,
                          sportIcons: sportIcons,
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
                    Get.to(() => InteractionTurfsPage(turfData: turfData, sportIcons: sportIcons,));
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
                      onTap: () => Get.to(() => InteractionEventsPage(data: turfEventsData, sportIcons: sportIcons,)),
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
                    return EventsTile(data: turfEventsData[index], sportIcons:sportIcons,);
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
                          Get.to(() => InteractionProductsPage(data: sportsProducts)),
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
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7),
                    itemBuilder: (context, index) {
                      return ProductsTile( data: sportsProducts[index]);
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
                          Get.to(() => InteractionTournamentsPage(data: upComingTurfTournaments,)),
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
                    children: List.generate(upComingTurfTournaments.length, (index) {
                      return TournamentsTile(data: upComingTurfTournaments[index]);
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
