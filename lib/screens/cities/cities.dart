import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waytoturf/screens/Interaction/interaction_selectsports.dart';
import 'package:waytoturf/screens/Interaction/interaction_widgets/interaction_continue.dart';
import 'package:waytoturf/screens/dashboard/dashboard_homepage.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/images.dart';
import 'package:waytoturf/utils/sizes.dart';

class Cities extends StatefulWidget {
  const Cities({super.key});

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  // List of preferred metro cities
  final List<String> metroCities = [
    "Indore",
    "Mumbai",
    "Delhi",
    "Bengaluru",
    "Hyderabad",
    "Chennai",
    "Kolkata",
    "Pune",
    "Ahmedabad",
  ];

  // All cities (expand this list as needed)
  final List<String> allCities = [
    "Mumbai",
    "Delhi",
    "Bengaluru",
    "Hyderabad",
    "Chennai",
    "Kolkata",
    "Pune",
    "Ahmedabad",
    "Surat",
    "Jaipur",
    "Lucknow",
    "Kanpur",
    "Nagpur",
    "Indore",
    "Thane",
    "Bhopal",
    "Patna",
    "Vadodara",
    "Ghaziabad",
    "Ludhiana",
    "Agra",
    "Nashik",
    "Faridabad",
    "Meerut",
  ];

  String selectedCity = "";
  String searchQuery = "";

  // Filtering cities based on search query
  List<String> get filteredCities {
    if (searchQuery.isEmpty) {
      return allCities;
    }
    return allCities
        .where((city) => city.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }


  var deviceStorage = GetStorage();


  @override
  void initState() {
    // TODO: implement initState
    final city = deviceStorage.read('city');
    if(city!=null){
      setState(() {
        selectedCity = city;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        leadingWidth: screenWidth,
        leading: Container(
          color: MyColors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              children: [
                selectedCity.isNotEmpty&&deviceStorage.read('userRegistered')? GestureDetector(child: const Icon(Icons.arrow_back_ios_new),onTap: (){
                  Get.offAll(()=>const HomePage());
                },):const SizedBox(),
                Hor(screenWidth*0.05),
                Image.asset(MyImages.logo,width: screenWidth*0.7,)
              ],
            ),
          ),
        ),
        backgroundColor: MyColors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search Bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search for your city",
                  prefixIcon: Icon(Icons.search, color: MyColors.appColor),
                  suffixIcon: Icon(FontAwesomeIcons.locationDot, color: MyColors.appColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Preferred Metro Cities Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Preferred Cities",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: MyColors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(horizontal: 5),
                height: screenHeight*0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: metroCities
                          .map(
                            (city) => GestureDetector(
                          onTap: () async {
                            setState(() {
                              selectedCity = city;
                              deviceStorage.write("city", city);
                            });
                          },
                          child: Chip(
                            avatar: Icon(
                              FontAwesomeIcons.city,
                              size: screenWidth*0.0325,
                              color: selectedCity==city ? MyColors.white:MyColors.appColor,
                            ),
                            label: Text(
                              city,
                              style: TextStyle(color: selectedCity==city ? MyColors.white:MyColors.black,fontSize: screenWidth*0.0325),
                            ),
                            backgroundColor: selectedCity == city
                                ? MyColors.appColor
                                : Colors.white,
                            side: BorderSide.none,
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // All Cities List
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    String city = filteredCities[index];
                    return ListTile(
                      leading: Icon(FontAwesomeIcons.city, color: MyColors.appColor,),
                      title: Text(city),
                      onTap: ()  async{
                        setState(() {
                          selectedCity = city;
                          deviceStorage.write("city", city);
                        });
                      },
                      trailing: selectedCity == city
                          ? Icon(Icons.check_circle, color: MyColors.appColor)
                          : null,
                    );
                  },
                ),
              ),
              // Use Current Location Button
              selectedCity.isNotEmpty && deviceStorage.read('userRegistered')? Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.offAll(()=>HomePage());
                    },
                    icon: Icon(Icons.my_location),
                    label: Text("USE CURRENT LOCATION"),
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: MyColors.appColor,
                        minimumSize: Size(screenWidth * 0.9, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                  ),
                  SizedBox(height: 10),
                  // Display Selected City
                  if (selectedCity.isNotEmpty)
                    Text(
                      "Selected City: $selectedCity",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16, color: MyColors.appColor),
                    ),
                ],
              ) : InteractionContinuePage(
                onPressed: (){
                  selectedCity.isNotEmpty ? Get.to(()=>const InteractionSelectSports()):null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}