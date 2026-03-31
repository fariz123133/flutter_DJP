import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  //popup edit
  void _showEditDialog(BuildContext context, UserProvider userProv) {
    // [MODIFIKASI]: Menambahkan controller untuk NIK
    TextEditingController nikController = TextEditingController(text: userProv.nik);
    TextEditingController emailController = TextEditingController(text: userProv.email);
    TextEditingController phoneController = TextEditingController(text: userProv.phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profil"),
        // [MODIFIKASI]: Membungkus Column dengan SingleChildScrollView agar tidak error saat keyboard muncul
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nikController, 
                decoration: const InputDecoration(labelText: "NIK/NPWP"),
                keyboardType: TextInputType.number, // Membuka keyboard angka
              ),
              TextField(
                controller: emailController, 
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: phoneController, 
                decoration: const InputDecoration(labelText: "Nomor Telepon"),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Batal")
          ),
          ElevatedButton(
              onPressed: () {
                // [MODIFIKASI]: Memasukkan nikController ke dalam fungsi update
                userProv.updateProfile(
                  nikController.text, 
                  emailController.text, 
                  phoneController.text
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC69931), // Warna tombol menyesuaikan tema DJP
                foregroundColor: Colors.white,
              ),
              child: const Text("Simpan")
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //pantau data user
    final userProv = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- Background Gradient ---
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.yellow.withOpacity(0.3),
                    Colors.purple.withOpacity(0.1),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.transparent
                  ],
                ),
              ),
            ),
          ),

          // --- Konten Utama ---
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  // FOTO PROFIL
                  const CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage('assets/images/rafa.jpg'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userProv.username.isEmpty ? "Agus Hengker" : userProv.username,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => _showEditDialog(context, userProv),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ubah Profil", style: TextStyle(color: Color(0xFFC69931), fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.edit, size: 14, color: Color(0xFFC69931)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- FORM FIELD ---
                  //ambil dari provider
                  _buildProfileField("NIK/NPWP", userProv.nik),
                  _buildProfileField("Email", userProv.email),
                  _buildProfileField("Nomor Telepon", userProv.phone),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}