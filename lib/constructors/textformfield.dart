import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class Textformfield extends StatefulWidget {
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted,onChanged;
  final bool?
      isEmailField,
      isPhoneField,
      isNameField,isLocationField,isOtpField,isDOBField,isGenderField;
  final bool isInputBorder;
  final int? maxLength;
  final FocusNode? focusNode;

  final Widget? suffixIcon, widget, prefixIcon;
  final TextAlign textAlign;
  final String? hintText,text,prefixText;
  final TextInputType? keyboardType;
  final Color? prefixIconColor, suffixIconColor;
  final FormFieldValidator<String>? validator;
  final bool readOnly, autofocus;
  final double borderradius,fontSize;
  final TextInputAction? textInputAction;
  final RegExp locationPattern = RegExp(r'^[a-zA-Z\s.\-]{2,18}$');
  final RegExp phoneNumberRegex = RegExp(r'^\d{3}-?\d{3}-?\d{4}$');
  final RegExp dobRegex = RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/([0-9]{4})$');
  final RegExp genderRegex = RegExp(r'^(Male|Female|Other)$');
  final RegExp otpRegex = RegExp(r'^\d{1}$');
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z][a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$');
  static bool focused = false;

  Textformfield({super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.text,
    required this.keyboardType,
    this.prefixIconColor,
    this.suffixIconColor,
    this.validator,
    this.readOnly = false,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.onFieldSubmitted,
    this.widget,
    this.isEmailField,
    this.isPhoneField,
    this.isNameField,
    this.autofocus = false,
    required this.borderradius,
    this.textInputAction,this.isLocationField,required this.textCapitalization, this.prefixText, required this.fontSize, required this.textAlign, this.isOtpField, this.maxLength, this.focusNode, this.isDOBField, this.isGenderField, this.isInputBorder=true
  });

  @override
  State<Textformfield> createState() => _TextFormFieldSignupState();
}

class _TextFormFieldSignupState extends State<Textformfield> {

  bool obsecureText = true;

  String? validateDOB(String input) {
    if (!widget.dobRegex.hasMatch(input)) {
      return 'Enter a valid date in DD/MM/YYYY format';
    }

    // Extract day, month, and year from input
    final parts = input.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    // Convert input to DateTime
    final dob = DateTime(year, month, day);
    final today = DateTime.now();

    // Calculate the age
    final age = today.year - dob.year;
    final hasReachedBirthday = (today.month > dob.month) || (today.month == dob.month && today.day >= dob.day);

    if (age > 14 || (age == 14 && hasReachedBirthday)) {
      return null; // Valid age
    } else {
      return 'You must be at least 14 years old';
    }
  }


@override
  Widget build(BuildContext context) {


    return TextFormField(
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      key: widget.key,
      controller: widget.controller,
      validator: widget.isEmailField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Please enter your Email";
        }
        if (!widget.emailRegex.hasMatch(value)) {
          return "Please enter a valid Email";
        }
        return null;
      }
          : widget.isPhoneField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Please enter your Mobile Number";
        }
        if (!widget.phoneNumberRegex.hasMatch(value)) {
          return "Please enter a valid Mobile Number";
        }
        return null;
      }
          : widget.isNameField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Please enter your Name";
        }
        return null;
      }
          : widget.isLocationField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Please enter your Location";
        }
        if (!widget.locationPattern.hasMatch(value)) {
          return "Indore/Pune/Mumbai/Bangalore";
        }
        return null;
      } : widget.isOtpField == true
          ? (value) {
        if (value!.isEmpty) {
          return "";
        }
        if (!widget.otpRegex.hasMatch(value)) {
          return "";
        }
        return null;
      }: widget.isDOBField == true
          ? (value) {
        return validateDOB(value!);
      }:widget.isGenderField == true
          ? (value) {
        if (value!.isEmpty) {
          return "Please enter your gender";
        }
        if (!widget.genderRegex.hasMatch(value)) {
          return "Please enter a valid gender (Male, Female, or Other)";
        }
        return null;
      }: null,
      decoration: InputDecoration(
        counterText: "",
        hoverColor: MyColors.appColor,
        prefixText: widget.prefixText,
        prefixStyle: GoogleFonts.poppins(
          color:Colors.black,
          fontSize:16,
        ),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.prefixIconColor,
        suffixIcon: widget.suffixIcon,
        suffixIconColor: widget.suffixIconColor,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(
          color: MyColors.grey,
          fontSize: 16,
        ),
        border: widget.isInputBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ):InputBorder.none,
        focusedBorder: widget.isInputBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: MyColors.grey, width: 3),
        ):InputBorder.none,
        errorBorder: widget.isInputBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: MyColors.redShade, width: 3),
        ):InputBorder.none,
        disabledBorder: widget.isInputBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ):InputBorder.none,
        enabledBorder: widget.isInputBorder ? OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderradius)),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ):InputBorder.none,
      ),
      cursorColor: MyColors.appColor,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign,
      keyboardType: widget.keyboardType,
      style: GoogleFonts.poppins(
        color: Colors.black, fontSize: widget.fontSize,),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      textCapitalization: widget.textCapitalization,
    );
  }
}