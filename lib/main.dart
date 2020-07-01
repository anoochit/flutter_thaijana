import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thaijana/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thai JaNa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(3, 21, 93, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.mitrTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}
