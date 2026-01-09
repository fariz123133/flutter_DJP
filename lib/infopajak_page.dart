<<<<<<< HEAD
=======
import 'package:flutter/material.dart';

class InfoPajakPage extends StatelessWidget {
  const InfoPajakPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List data dummy untuk banner
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
          onPressed: () => Navigator.maybePop(context),
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
          return _buildInfoBanner(context, banners[index]);
        },
      ),
    );
  }

  Widget _buildInfoBanner(BuildContext context, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // 1. Gambar Banner
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 190,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 190,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                );
              },
            ),

            // 2. Overlay Gradasi Hitam (Agar teks terbaca)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // 3. Teks Info Selengkapnya
            Positioned(
              bottom: 15,
              left: 20,
              right: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Update Perpajakan Terbaru",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        "Info Selengkapnya",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFC69931), // Warna emas aksen
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),

            // 4. InkWell untuk efek klik
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Logika ketika banner diklik
                    print("Banner diklik!");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> 1670ffef32f89ac839cce4b039cd2df4cc63ea7a
