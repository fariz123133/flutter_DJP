import 'package:flutter/material.dart';

class InfoPajakPage extends StatelessWidget {
  const InfoPajakPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List data dummy untuk banner (Ganti path sesuai asset kamu nanti)
    final List<String> banners = [
      '/assets/images/banner/1.jpg',
      '/assets/images/banner/2.jpg',
      '/assets/images/banner/3.jpg',
      '/assets/images/banner/4.jpg',
      '/assets/images/banner/6.jpg',
      '/assets/images/banner/8.jpeg',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            // Logika kembali jika diperlukan
          },
        ),
        title: const Text(
          "Informasi Seputar Perpajakan",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        itemCount: banners.length,
        itemBuilder: (context, index) {
          return _buildInfoBanner(banners[index]);
        },
      ),
    );
  }

  Widget _buildInfoBanner(String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Membuat sudut membulat
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: 180, // Tinggi disesuaikan agar simetris
          errorBuilder: (context, error, stackTrace) {
            // Fallback jika gambar tidak ditemukan
            return Container(
              height: 180,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}