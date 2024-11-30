import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/images.dart';

class DashboardController extends GetxController{
  static DashboardController get instance => Get.find();


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


  void userRegistered() async {
    deviceStorage.write('userRegistered', true);
  }

}