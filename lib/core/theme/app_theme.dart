import 'package:doctor_mate/core/theme/app_color.dart';
import 'package:doctor_mate/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData appTheme() {
    return ThemeData(
      primaryColor: ColorsManager.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      fontFamily: GoogleFonts.inter().fontFamily,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: ColorsManager.primaryColor,
        unselectedItemColor: ColorsManager.lightGreen,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyles.font12BlueSemiBold,
        unselectedLabelStyle: TextStyles.font11GrayRegular,
      ),
    );
  }
}
