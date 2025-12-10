import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==========================================================
// SCREEN UTAMA: DASHBOARD (STATEFUL)
// ==========================================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // --- STATE UNTUK BOTTOM NAVIGASI ---
  // 0: Home, 1: Info Pajak, 2: Bayar, 3: Kartu Digital, 4: Profil
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("Navigasi ke Indeks: $index");
  }

  // Definisi Warna
  final Color primaryBlue = const Color(0xFF2B3A67);
  final Color accentGold = const Color(0xFFC69931);
  final Color bgYellowLight = const Color(0xFFFFFBE0);
  final int alpha10Percent = 25;

  // --- DIMENSI BOTTOM NAV ---
  static const double notchRadius = 35.0;
  static const double navBarBaseHeight = 60.0;
  static const double notchHeight = 40.0;

  final double navBarStackHeight = navBarBaseHeight + notchHeight;

  // Daftar Ikon dan Label untuk Bottom Nav
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_outlined, 'label': "Home"},
    {'icon': Icons.info_outline, 'label': "Info Pajak"},
    {'icon': Icons.credit_card_outlined, 'label': "Bayar", 'badge': true},
    {'icon': Icons.article_outlined, 'label': "Kartu Digital"},
    {'icon': Icons.person_outline, 'label': "Profil"},
  ];

  // --- Widget Pembantu Menu Card (Horizontal) ---

  Widget _buildMenuCardHorizontal(String title, IconData icon, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon (Left)
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 10),

          // Teks (Right)
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Pembantu Bottom Nav ---

  // Lingkaran Putih & Ikon Navigasi (Aktif)
  Widget _buildActiveCircle(IconData icon) {
    final double circleDiameter = notchRadius * 2;
    const double innerIconSize = 36;

    return Container(
      width: circleDiameter,
      height: circleDiameter,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          color: primaryBlue,
          size: innerIconSize,
        ),
      ),
    );
  }

  // Item Navigasi Kustom (Menangani Ikon Non-Aktif dan Label Aktif/Non-Aktif)
  Widget _buildNavItemCustom(IconData icon, String label, int index, {bool showRpBadge = false}) {
    final bool isSelected = index == _selectedIndex;

    // Jika item aktif, hanya tampilkan label dan padding kosong (lingkaran ikon di-handle di Stack utama)
    if (isSelected) {
      return Expanded(
        child: InkWell(
          onTap: () => _onItemTapped(index),
          child: SizedBox(
            height: navBarBaseHeight,
            // Widget Placeholder/Teks
            child: Center(
              child: Padding(
                // Padding di atas agar label berada di bawah lingkaran putih
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Jika item tidak aktif, tampilkan ikon dan label di dalam kolom normal
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onItemTapped(index),
          child: SizedBox(
            height: navBarBaseHeight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(icon, color: Colors.white, size: 24),
                    if (showRpBadge)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: accentGold,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            "Rp.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                // Label Non-Aktif
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / 5;
    final double centerActiveX = (_selectedIndex + 0.5) * itemWidth;
    final IconData activeIcon = _navItems[_selectedIndex]['icon'];


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HEADER - PERUBAHAN DI SINI UNTUK GAMBAR
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
                      // MENGGANTI TEXT DENGAN IMAGE.ASSET
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          // Ganti 'logo_djp.png' sesuai nama file logo Anda
                          'assets/images/logO.png',
                          fit: BoxFit.contain,
                          // Jika file tidak ditemukan, ini akan memberikan error runtime.
                          // Pastikan sudah dideklarasikan di pubspec.yaml.
                        ),
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
                childAspectRatio: 2.2,
                children: [
                  _buildMenuCardHorizontal("Kalkulator\nPajak", Icons.calculate_outlined, accentGold, bgYellowLight),
                  _buildMenuCardHorizontal("Reset\nEFIN", Icons.looks_one_outlined, accentGold, bgYellowLight),
                  _buildMenuCardHorizontal("Lokasi KKP\nTerdekat", Icons.location_on_outlined, accentGold, bgYellowLight),
                  _buildMenuCardHorizontal("Peraturan\nPerpajakan", Icons.description_outlined, accentGold, bgYellowLight),
                ],
              ),
              const SizedBox(height: 24),
              // 4. TENGGAT PAJAK
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
              SizedBox(height: navBarStackHeight),
            ],
          ),
        ),
      ),

      // 6. BOTTOM NAV - NOTCH CEMBUNG KE ATAS
      bottomNavigationBar: Container(
        height: navBarStackHeight,
        color: Colors.transparent,
        child: Stack(
          children: [
            // Custom Painter untuk Dasar Biru dan Lengkungan
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(screenWidth, navBarBaseHeight),
                // Custom Painter Dinamis
                painter: BottomNavPainterSelected(
                  primaryBlue: primaryBlue,
                  notchCenter: centerActiveX,
                  notchRadius: notchRadius,
                  notchHeight: notchHeight,
                ),
                child: SizedBox(
                  height: navBarBaseHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Item-item Navigasi Kustom
                      _buildNavItemCustom(_navItems[0]['icon'], _navItems[0]['label'], 0),
                      _buildNavItemCustom(_navItems[1]['icon'], _navItems[1]['label'], 1),
                      _buildNavItemCustom(_navItems[2]['icon'], _navItems[2]['label'], 2, showRpBadge: true),
                      _buildNavItemCustom(_navItems[3]['icon'], _navItems[3]['label'], 3),
                      _buildNavItemCustom(_navItems[4]['icon'], _navItems[4]['label'], 4),
                    ],
                  ),
                ),
              ),
            ),

            // Custom Circle (Lingkaran Putih dan Ikon Aktif)
            Positioned(
              // bottom disesuaikan
              bottom: navBarBaseHeight - (notchRadius + 10.0),
              left: centerActiveX - notchRadius, // Posisi dinamis
              child: _buildActiveCircle(activeIcon), // Ikon dinamis
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// CUSTOM PAINTER UNTUK NOTCH LENGKUNGAN (DINAMIS)
// ==========================================================
class BottomNavPainterSelected extends CustomPainter {
  final Color primaryBlue;
  final double notchCenter;
  final double notchRadius;
  final double notchHeight;

  BottomNavPainterSelected({
    required this.primaryBlue,
    required this.notchCenter,
    required this.notchRadius,
    required this.notchHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = primaryBlue;
    final Path path = Path();

    double barHeight = size.height;
    double r = notchRadius;

    double horizontalOffset = r + 5.0;

    double startCurveX = notchCenter - horizontalOffset;
    double endCurveX = notchCenter + horizontalOffset;

    double controlPointX1 = r * 0.5;
    double controlPointX2 = r * 1.1;
    double peakY = -notchHeight;

    path.moveTo(0, barHeight);
    path.lineTo(0, 0);

    path.lineTo(math.max(0, startCurveX), 0);

    // Hanya digambar jika pusat lengkungan tidak terlalu dekat ke tepi
    if (startCurveX > 0 && endCurveX < size.width) {
      path.cubicTo(
          startCurveX + controlPointX1, 0,
          notchCenter - controlPointX2, peakY,
          notchCenter, peakY
      );

      path.cubicTo(
          notchCenter + controlPointX2, peakY,
          endCurveX - controlPointX1, 0,
          endCurveX, 0
      );
    }

    path.lineTo(size.width, 0);

    path.lineTo(size.width, barHeight);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BottomNavPainterSelected oldDelegate) =>
      oldDelegate.notchCenter != notchCenter;
}

// ==========================================================
// WIDGET KHUSUS ANIMASI TENGGAT PAJAK (TIDAK BERUBAH)
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
        Expanded(
          child: Container(
            height: cardHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
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