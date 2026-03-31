import 'package:djp/pay_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user_provider.dart';
import 'main_screen.dart';
import 'login_page.dart'; // Import file dashboard yang baru dibuat

void main() {
  runApp(
     ChangeNotifierProvider(
         create:(context) => UserProvider(),
     child: const MyApp(),
     ),
  );
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
      home: const SplashScreen(),
    );
  }
}

// --- WIDGET SPLASH SCREEN ---
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Tunggu 3 detik lalu pindah ke Login
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage())
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B3A67),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 100,
                errorBuilder: (context, error, stack) => const Icon(Icons.account_balance, size: 100, color: Colors.white)),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}