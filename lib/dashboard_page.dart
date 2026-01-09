import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==========================================================
// SCREEN UTAMA: DASHBOARD (STATEFUL)
// ==========================================================
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Definisi Warna
  final Color primaryBlue = const Color(0xFF2B3A67);
  final Color accentGold = const Color(0xFFC69931);
  final Color bgYellowLight = const Color(0xFFFFFBE0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 27,
                    child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
                  ),
                  Icon(Icons.chat, size: 30, color: primaryBlue),
                ],
              ),
              const SizedBox(height: 24),

              // --- GREETING ---
              const Text("Hai, Agus Hengker!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text("Selamat Datang di M-Pajak!",
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 24),

              // --- MENU GRID ---
              const Text("Layanan Lainnya",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
                children: [
                  _buildMenuCardHorizontal("Kalkulator Pajak", Icons.calculate_outlined),
                  _buildMenuCardHorizontal("Reset EFIN", Icons.looks_one_outlined),
                  _buildMenuCardHorizontal("Lokasi KKP", Icons.location_on_outlined),
                  _buildMenuCardHorizontal("Peraturan", Icons.description_outlined),
                ],
              ),
              const SizedBox(height: 24),

              // --- TENGGAT PAJAK ---
              const Text("Tenggat Pajak",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),

              // WIDGET AUTO SCROLL DI SINI
              const AutoScrollTaxInfo(),

              const SizedBox(height: 100), // Spasi agar tidak tertutup Navbar
            ],
          ),
        ),
      );
  }

  Widget _buildMenuCardHorizontal(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: bgYellowLight, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: accentGold, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(title,
                  style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}

// ==========================================================
// WIDGET KHUSUS ANIMASI TENGGAT PAJAK (VERSI PERBAIKAN)
// ==========================================================
class AutoScrollTaxInfo extends StatefulWidget {
  const AutoScrollTaxInfo({super.key});

  @override
  State<AutoScrollTaxInfo> createState() => _AutoScrollTaxInfoState();
}

class _AutoScrollTaxInfoState extends State<AutoScrollTaxInfo> {
  final List<Map<String, String>> _taxData = [
    {"date": "31", "month": "Okt", "desc": "Pelaporan SPT Masa PPN Masa September 2025"},
    {"date": "30", "month": "Nov", "desc": "Pelaporan SPT Masa PPN Masa Oktober 2025"},
    {"date": "31", "month": "Des", "desc": "Pelaporan SPT Masa PPN Masa November 2025"},
    {"date": "31", "month": "Jan", "desc": "Pelaporan SPT Masa PPN Masa Desember 2025"},
    {"date": "28", "month": "Feb", "desc": "Pelaporan SPT Masa PPN Masa Januari 2026"},
  ];

  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _taxData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double containerHeight = 110.0;

    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- BAGIAN KIRI: TAHUN (STATIS/DIAM) ---
          Container(
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFF2B3A67), // Biru gelap Dashboard
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11),
                bottomLeft: Radius.circular(11),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tahun", style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text(
                  "2025",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Divider vertikal tipis
          Container(width: 1, color: Colors.grey.shade200),

          // --- BAGIAN KANAN: KONTEN TENGGAT (AUTO SCROLL) ---
          Expanded(
            child: ClipRRect(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _taxData.length,
                itemBuilder: (context, index) {
                  final data = _taxData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        // Kotak Emas Tanggal
                        Container(
                          width: 55,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC69931),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data["date"]!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data["month"]!,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Detail Keterangan
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Keterangan",
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                data["desc"]!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }
}