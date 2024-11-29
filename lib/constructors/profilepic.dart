import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/colors.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key, required this.circleRadius, this.isEditable=false, required this.image});

  final double circleRadius;
  final bool isEditable;
  final ImageProvider image;


  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double circleRadius = widget.circleRadius;
        // double circleRadius = screenWidth * 0.16;
        double penIconSize = circleRadius * 0.5;

        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.appColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: circleRadius,
                  backgroundColor: MyColors.appColor,
                  backgroundImage: widget.image,
                ),
              ),
            ),
            widget.isEditable ? Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: penIconSize,
                height: penIconSize,
                decoration: BoxDecoration(
                  color: MyColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyColors.grey,
                    width: 1,
                  ),
                ),
                child: Icon(
                  FontAwesomeIcons.solidPenToSquare,
                  color: MyColors.appColor,
                  size: penIconSize *
                      0.5, // Icon size relative to container
                ),
              ),
            ):Text(""),
          ],
        );
      },
    );
  }
}