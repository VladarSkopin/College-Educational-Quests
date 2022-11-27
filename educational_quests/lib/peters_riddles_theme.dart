import 'package:flutter/material.dart';

class PetersRiddlesTheme {

  static TextTheme darkTextTheme = const TextTheme(
      bodyText1: TextStyle(
          color: Colors.amber,
          fontFamily: 'Papyrus',
          fontSize: 20,
          fontWeight: FontWeight.w500
      ),
      headline1: TextStyle(
          color: Colors.white,
          fontFamily: 'Papyrus',
          fontSize: 22,
          fontWeight: FontWeight.w600
      )
  );

  static TextTheme lightTextTheme = const TextTheme(
      bodyText1: TextStyle(
          color: Colors.indigo,
          fontFamily: 'Papyrus',
          fontSize: 20,
          fontWeight: FontWeight.w500
      ),
      headline1: TextStyle(
          color: Colors.white,
          fontFamily: 'Papyrus',
          fontSize: 22,
          fontWeight: FontWeight.w600
      )
  );

  static ThemeData petersRiddlesDarkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            centerTitle: true
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.tealAccent, backgroundColor: Colors.blueGrey
        ),
        cardColor: Colors.black,
        textTheme: darkTextTheme
    );
  }

  static ThemeData petersRiddlesLightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            centerTitle: true
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent
        ),
        cardColor: Colors.black,
        textTheme: lightTextTheme
    );
  }


}