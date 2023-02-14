
import 'package:flutter/material.dart';

class MyTheme {

  static const Color orange = Color(0xFFF38B2D);
  static const Color lightOrange = Color(0xFFF4A155);
  static  ThemeData theme = ThemeData(
    primaryColor: lightOrange,
    scaffoldBackgroundColor: lightOrange,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: lightOrange,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      titleTextStyle: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.white
      )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: lightOrange
      ),
        labelLarge: TextStyle(
        fontSize: 37,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
        titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: lightOrange
      ),
        bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black
      )
    )
  );
}