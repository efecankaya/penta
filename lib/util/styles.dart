import 'package:flutter/material.dart';
import 'package:penta/util/colors.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle? kHeadingTextStyle = GoogleFonts.lato(
  color: AppColors.headingColor,
  fontWeight: FontWeight.w400,
  fontSize: 34.0,
);

final kButtonLightTextStyle = GoogleFonts.lato(
  color: AppColors.darkButtonTextColor,
  fontSize: 20.0,
);

final kButtonDarkTextStyle = GoogleFonts.lato(
  color: AppColors.darkButtonTextColor,
  fontSize: 20.0,
);

final kAppBarTitleTextStyle = GoogleFonts.lato(
  color: AppColors.appBarTitleTextColor,
  fontSize: 24.0,
  fontWeight: FontWeight.w500,
);

final kBoldLabelStyle = GoogleFonts.lato(
  fontSize: 17.0,
  color: AppColors.textColor,
  fontWeight: FontWeight.w600,
);

final kLabelStyle = GoogleFonts.lato(
  fontSize: 17.0,
  color: AppColors.textColor,
);