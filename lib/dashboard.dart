import 'dart:async';
import 'package:flutter/material.dart';

// ==========================================================
// SCREEN UTAMA: DASHBOARD
// ==========================================================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi Warna
    final Color primaryBlue = const Color(0xFF2B3A67);
    final Color accentGold = const Color(0xFFC69426);
    final Color bgYellowLight = const Color(0xFFFFFDE7);

    // Nilai Alpha untuk Opacity 0.1: (0.1 * 255) = 25
    final int alpha10Percent = 25;

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
                  Icon(Icons.menu, size: 30, color: primaryBlue),
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
              const Text(
                "Selamat Datang di M-Pajak!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
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
                childAspectRatio: 1.8,
                children: [
                  _buildMenuCard("Kalkulator\nPajak", Icons.calculate, accentGold, bgYellowLight),
                  _buildMenuCard("Reset\nEFIN", Icons.looks_one, accentGold, bgYellowLight),
                  _buildMenuCard("Lokasi KKP\nTerdekat", Icons.location_on, accentGold, bgYellowLight),
                  _buildMenuCard("Peraturan\nPerpajakan", Icons.description, accentGold, bgYellowLight),
                ],
              ),
              const SizedBox(height: 24),

              // 4. TENGGAT PAJAK (AUTO SCROLL VERTICAL)
              const Text(
                "Tenggat Pajak",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
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
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                    boxShadow: [
                      BoxShadow(
                        // PERBAIKAN WARNING: Menggunakan withAlpha
                        color: Colors.black.withAlpha(alpha10Percent),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    const Icon(Icons.my_location, color: Color(0xFF2B3A67), size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "\"Jalan Genuksari RT. 04/ RW. 05....",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Text(
                        "Ubah",
                        style: TextStyle(color: accentGold, fontWeight: FontWeight.bold)
                    ),
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

  // --- Widget Pembantu ---

  Widget _buildMenuCard(String title, IconData icon, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================
// WIDGET KHUSUS ANIMASI TENGGAT PAJAK (AUTO SCROLL VERTIKAL TERBATAS)
// ==========================================================
class AutoScrollTaxInfo extends StatefulWidget {
  const AutoScrollTaxInfo({super.key});

  @override
  State<AutoScrollTaxInfo> createState() => _AutoScrollTaxInfoState();
}

class _AutoScrollTaxInfoState extends State<AutoScrollTaxInfo> {

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
      "desc": "Pelaporan SPT Masa PPN Masa Desember 2025"
    },
    {
      "date": "28",
      "month": "Feb",
      "desc": "Pelaporan SPT Masa PPN Masa Januari 2026"
    },
  ];

  late ScrollController _scrollController;
  late Timer _timer;
  final double _itemHeight = 90.0;
  final Color primaryBlue = const Color(0xFF2B3A67);
  final Color accentGold = const Color(0xFFC69426);
  // Nilai Alpha untuk Opacity 0.1: (0.1 * 255) = 25
  final int alpha10Percent = 25;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        double targetScroll = currentScroll + _itemHeight;

        if (targetScroll >= maxScroll) {
          Future.delayed(const Duration(seconds: 2), () {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(0.0);
            }
          });
        } else {
          _scrollController.animateTo(
            targetScroll,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
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
    final double cardHeight = 90.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kartu Kiri (Tahun 2025) - Static
        Container(
          height: cardHeight,
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: primaryBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tahun",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                "2025",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Kartu Kanan (Tanggal & Keterangan) - Auto Scroll Vertikal
        Expanded(
          child: Container(
            height: cardHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                    // PERBAIKAN WARNING: Menggunakan withAlpha
                    color: Colors.black.withAlpha(alpha10Percent),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _taxData.length,
                itemExtent: _itemHeight,
                itemBuilder: (context, index) {
                  final data = _taxData[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        // Kotak Emas Tanggal
                        Container(
                          width: 45,
                          height: 60,
                          decoration: BoxDecoration(
                            color: accentGold,
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
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                data["month"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
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
                                style: TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                data["desc"]!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
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
            ),
          ),
        ),
      ],
    );
  }
}