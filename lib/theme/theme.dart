import 'package:dogecoin/theme/app_colors.dart';
import 'package:flutter/material.dart';

final themeData = ThemeData(
  textTheme: TextTheme(
    //Comic Sans MS
    displayMedium: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      color: AppColors.whiteColor,
    ),
    //jost
    titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
    //Comic Sans MS
    headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700
    )
  ),
  scaffoldBackgroundColor: AppColors.primaryColor,
);
