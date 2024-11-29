import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';
import 'package:waytoturf/utils/colors.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {


    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final screenHeight = MediaQuery.of(context).size.height; // Get screen height

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: ()=>Get.back(),child: Icon(Icons.arrow_back_ios_new)),
        title: Text('T&C',style: GoogleFonts.poppins(),),
        titleSpacing: screenWidth*0.275,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading for Terms and Conditions
              Text(
                'Terms and Conditions',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              SizedBox(height: 16),
        
              // Terms and Conditions content
              Text(
                'Welcome to Our Way To Turf App! Please read these Terms and Conditions carefully before using our app. By accessing or using the app, you agree to be bound by these terms.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              Text(
                '1. General Information',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'This is a dummy app created for demonstration purposes only. The information provided within the app is not 100% real and should not be used as factual data. The app and its contents are not intended for any commercial or professional use.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '2. App Usage',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'By using this app, you agree to use it only for lawful purposes and in a manner that does not violate the rights of others. You are prohibited from using the app in a way that could damage, disable, or impair the service or interfere with any other party\'s use of the app.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '3. Disclaimer of Warranties',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'The app is provided "as is" without any warranties or guarantees, express or implied. We do not warrant that the app will meet your requirements or that the operation of the app will be uninterrupted or error-free. Use of the app is at your own risk.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '4. Data Collection and Privacy',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'We respect your privacy. The app does not collect any personal information or track user activity unless otherwise explicitly stated. Any information provided is stored only for the duration of the app session and is not shared with third parties.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '5. Third-Party Links',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'Our app may contain links to third-party websites or services that are not owned or controlled by us. We are not responsible for the content, privacy policies, or practices of any third-party sites or services.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '6. Limitation of Liability',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'In no event shall the app developers, owners, or affiliates be liable for any direct, indirect, incidental, special, consequential, or punitive damages, or any loss of profits or data, arising from or related to the use of the app.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '7. Changes to Terms',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'We reserve the right to modify or update these terms and conditions at any time without prior notice. Any changes will be reflected in the updated version of these terms within the app.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '8. Governing Law',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'These terms and conditions shall be governed and construed in accordance with the laws of the jurisdiction in which the app owner resides, without regard to its conflict of law principles.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                '9. Contact Us',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.appColor,
                ),
              ),
              Text(
                'If you have any questions or concerns about these Terms and Conditions, please contact us at: support@dummyapp.com.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 30),
        
              // Copyright Information
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '© DiligentSolver 2024. All rights reserved.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
