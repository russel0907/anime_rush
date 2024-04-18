import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vsing/screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff0C0A32),
        scaffoldBackgroundColor: const Color(0xff0C0A32),
        appBarTheme: const AppBarTheme(
          color: Color(0xff0C0A32),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.fredokaTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme.copyWith(
                bodyLarge: const TextStyle(color: Colors.white),
                bodyMedium: const TextStyle(color: Colors.white),
                labelLarge: const TextStyle(color: Colors.white),
                labelMedium: const TextStyle(color: Colors.white),
                labelSmall: const TextStyle(color: Colors.white),
              ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
