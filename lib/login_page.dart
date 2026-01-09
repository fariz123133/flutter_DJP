import 'package:flutter/material.dart';
import 'main_screen.dart'; // Import main_screen

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Warna sesuai tema
  final Color primaryBlue = const Color(0xFF2B3A67);
  final Color accentGold = const Color(0xFFC69931);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background dasar aplikasi putih
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER: WADAH MELENGKUNG DENGAN GRADASI & SHADOW ---
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                // 1. GRADASI DI DALAM LENGKUNGAN
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF8E99C9), // Ungu muda atas
                    Color(0xFFD9DDF3), // Transisi tengah
                    Colors.white,      // Putih di ujung lengkungan bawah
                  ],
                ),
                // 2. BENTUK LENGKUNGAN
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(250, 120),
                ),
                // 3. SHADOW DI BAWAH LENGKUNGAN
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Logo Circle
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.account_balance, size: 60, color: primaryBlue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Selamat Datang!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    child: Text(
                      "Apabila sudah memiliki akun, silahkan login menggunakan akun DJP Online yang sudah di Aktivasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- FORM INPUT ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Username"),
                  _buildTextField(_usernameController, "Masukkan Username Anda"),
                  const SizedBox(height: 16),
                  _buildLabel("NIK/NPWP"),
                  _buildTextField(_nikController, "Masukkan NIK atau NPWP Anda"),
                  const SizedBox(height: 16),
                  _buildLabel("Password"),
                  _buildTextField(_passwordController, "Masukkan Password Anda", isPassword: true),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("Lupa Password?", style: TextStyle(color: Colors.black54)),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- TOMBOL LOGIN ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke MainScreen agar navbar muncul
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- FOOTER DAFTAR ---
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun? "),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Daftar di sini",
                            style: TextStyle(color: accentGold, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}