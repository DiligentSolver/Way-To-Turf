import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/sizes.dart';

class TurfCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, IconData> sportIcons;

  const TurfCard(this.data, {super.key, required this.sportIcons});



  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: MyColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Turf Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                child: Image(
                  image: AssetImage(data['image']),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Discount Tag
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: MyColors.appColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data['discount'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth*0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: MyColors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    data['name'],
                    style: TextStyle(
                      color: MyColors.darkerGrey,
                      fontSize: screenWidth*0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: MyColors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      // Rating
                      const Icon(Icons.star, size: 16, color: MyColors.golden),
                      const SizedBox(width: 4),
                      Text(
                        "${data['rating']} (${data['reviews']})",
                        style: TextStyle(fontSize: screenWidth*0.03, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Turf Name
                // Location & Distance
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data['location']}",
                          style: TextStyle(fontSize: screenWidth*0.03, color: MyColors.darkGrey),
                        ),
                        Text(
                          "${data['distance']}",
                          style: TextStyle(fontSize: screenWidth*0.03, color: MyColors.darkGrey),
                        ),
                      ],
                    ),
                    Text(
                      data['price'],
                      style:
                      TextStyle(fontSize: screenWidth*0.05, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Ver(8),
                // Sports
                Row(
                  children: data['sports']
                      .map<Widget>((sport) => Row(
                        children: [
                          Icon(sportIcons[sport],color: MyColors.appColor,),
                          Hor(5),
                          Text(
                            sport,
                            style: TextStyle(fontSize: screenWidth*0.03),
                          ),
                          Hor(10),
                        ],
                      ))
                      .toList(),
                ),
              ],
            ),
          ),
          Container(
          height: 5, // Height of the border
          decoration: BoxDecoration(
    color: MyColors.appColor, // Bottom border color
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(4.0),
    bottomRight: Radius.circular(4.0),
    ),)),
        ],
      ),
    );
  }
}
