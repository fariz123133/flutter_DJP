import 'dart:async';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi Warna
    final Color primaryBlue = const Color(0xFF2B3A67);
    final Color accentGold = const Color(0xFFD4A017);
    final Color bgYellowLight = const Color(0xFFFFF9C4);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: accentGold, width: 2),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 24,
                      child: Text(
                        "djp",
                        style: TextStyle(
                            color: primaryBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Icon(Icons.chat_bubble_outline, size: 30, color: primaryBlue),
                ],
              ),
              const SizedBox(height: 24),

              // 2. GREETING
              const Text(
                "Hai, Agus Hengker!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Selamat Datang di M-Pajak!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // 3. LAYANAN LAINNYA
              const Text(
                "Layanan Lainnya",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _buildMenuCard("Kalkulator\nPajak", Icons.calculate, accentGold, bgYellowLight),
                  _buildMenuCard("Reset\nEFIN", Icons.pin_invoke, accentGold, bgYellowLight),
                  _buildMenuCard("Lokasi KKP\nTerdekat", Icons.location_on, accentGold, bgYellowLight),
                  _buildMenuCard("Peraturan\nPerpajakan", Icons.description, accentGold, bgYellowLight),
                ],
              ),
              const SizedBox(height: 24),

              // 4. TENGGAT PAJAK (BERGERAK OTOMATIS)
              const Text(
                "Tenggat Pajak",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              // Memanggil Widget Khusus Animasi di bawah
              const AutoScrollTaxInfo(), 
              
              const SizedBox(height: 24),

              // 5. LOKASI ANDA
              const Text(
                "Lokasi Anda",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.my_location, color: Colors.black87),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "\"Jalan Genuksari RT. 04/ RW. 05....",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Ubah", style: TextStyle(color: accentGold, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // 6. BOTTOM NAV
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
        child: Icon(Icons.home, color: primaryBlue, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: primaryBlue,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.info_outline, "Info Pajak"),
              _buildNavItem(Icons.payment, "Bayar"),
              const SizedBox(width: 48),
              _buildNavItem(Icons.credit_card, "Kartu Digital"),
              _buildNavItem(Icons.person_outline, "Profil"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, Color iconColor, Color bgColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              title,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}

// ==========================================================
// WIDGET KHUSUS ANIMASI TENGGAT PAJAK (AUTO SCROLL CEPAT)
// ==========================================================
class AutoScrollTaxInfo extends StatefulWidget {
  const AutoScrollTaxInfo({super.key});

  @override
  State<AutoScrollTaxInfo> createState() => _AutoScrollTaxInfoState();
}

class _AutoScrollTaxInfoState extends State<AutoScrollTaxInfo> {
  // Data sesuai gambar tgl.png
  final List<Map<String, String>> _taxData = [
    {
      "date": "31",
      "month": "Okt",
      "desc": "Pelaporan SPT Masa PPN Masa September 2025"
    },
    {
      "date": "30",
      "month": "Nov",
      "desc": "Pelaporan SPT Masa PPN Masa Oktober 2025"
    },
    {
      "date": "31",
      "month": "Des",
      "desc": "Pelaporan SPT Masa PPN Masa November 2025"
    },
    {
      "date": "31",
      "month": "Jan",
      "desc": "Pelaporan SPT Masa PPN Masa Desember 2026"
    },
    {
      "date": "28",
      "month": "Feb",
      "desc": "Pelaporan SPT Masa PPN Masa Januari 2026"
    },
  ];

  late ScrollController _scrollController;
  late Timer _timer;
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    // Timer diatur agar lebih responsif dan cepat
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients) {
        // Kecepatan gerak ditambah (semakin besar angka, semakin cepat)
        _scrollPosition += 2.0; 
        _scrollController.jumpTo(_scrollPosition);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Tinggi area kartu
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        // ItemCount tidak didefinisikan agar 'infinite'
        itemBuilder: (context, index) {
          // Modulo logic untuk looping data terus menerus
          final data = _taxData[index % _taxData.length];
          
          return Container(
            width: 300, // Lebar per kartu
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                // Kotak Emas Tanggal
                Container(
                  width: 60,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC69426), // Warna Emas
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data["date"]!,
                        style: const TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 20
                        ),
                      ),
                      Text(
                        data["month"]!,
                        style: const TextStyle(
                          color: Colors.white, 
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                
                // Teks Keterangan
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Keterangan", 
                        style: TextStyle(fontSize: 10, color: Colors.grey)
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data["desc"]!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w500,
                          color: Colors.black87
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}