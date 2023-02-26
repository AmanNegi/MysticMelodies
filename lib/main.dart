import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysticmelodies/globals.dart';
import 'package:mysticmelodies/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.dark(
          background: darkColor,
          primary: accentColor,
          secondary: accentLightColor,
        ),
      ),
      home: const WelcomePage(),
    );
  }
}
