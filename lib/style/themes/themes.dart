import 'package:catrx/style/themes/themes_conestants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme:  AppBarTheme(
    elevation: 0,
    color: defaultColor,
    titleTextStyle: TextStyle(
      color: defaultColor,
      fontSize: 23,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(defaultColor),
    ),
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: defaultColor,
    ),
  ),
  primaryColor: Colors.red,
  hintColor: Colors.green,
  errorColor: Colors.yellowAccent,
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark
    /*progressIndicatorTheme:  const ProgressIndicatorThemeData(
    color: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
      color: HexColor('202124'),
      iconTheme: const IconThemeData(
        color: Colors.grey,),
      elevation: 20,
      foregroundColor: Colors.grey
  ) ,
  scaffoldBackgroundColor: HexColor(
      '202124'
  ),
  textTheme:  const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('202124'),
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
  ),*/
    );
