import 'package:flutter/material.dart';

ThemeData lite_theme = ThemeData(
  primarySwatch: Colors.blue,
    textTheme:TextTheme(
        bodyText1:TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25
        ),
        bodyText2:TextStyle(
            color: Color(0xFF454545),
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),
        overline: TextStyle(
            color: Color(0xFF808080),
            fontWeight: FontWeight.bold,
            fontSize: 14
        )

    ) ,
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        titleSpacing: 20,
        titleTextStyle: TextStyle(fontSize: 20,color: Colors.black),
        iconTheme:  IconThemeData(
            color: Colors.black
        )
    ),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor:Colors.white,
        type: BottomNavigationBarType.fixed

    )
);
ThemeData dark_theme = ThemeData(
    textTheme:TextTheme(
        bodyText1:TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),
        bodyText2:TextStyle(
            color: Color(0xFFC1C0C0),
            fontWeight: FontWeight.bold,
            fontSize: 14
        ),
        overline: TextStyle(
            color: Color(0xFFC1C0C0),
            fontWeight: FontWeight.bold,
            fontSize: 13
        )

    ) ,
    appBarTheme: AppBarTheme(

        backgroundColor: Color(0xB9747272),
        elevation: 0,
        titleSpacing: 20,
        titleTextStyle: TextStyle(fontSize: 20,color: Colors.black),
        iconTheme:  IconThemeData(
            color: Colors.black
        )
    ),
    scaffoldBackgroundColor: Color(0xB9747272),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor:Color(0xB9747272),
        type: BottomNavigationBarType.fixed

    )
);