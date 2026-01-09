import 'package:djp/pay_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_screen.dart';
import 'login_page.dart'; // Import file dashboard yang baru dibuat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M-Pajak Clone',
      theme: ThemeData(
        // Kita set Font secara global di sini, 
        // jadi di dashboard_page.dart tidak perlu import google_fonts lagi
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      // Panggil Class dari file dashboard_page.dart
      home: const LoginPage(),
    );
  }
}