import 'package:flutter/material.dart';
import 'dashboard_page.dart'; // Pastikan dashboard_page.dart tetap ada
import 'pay_page.dart';       // Pastikan pay_page.dart tetap ada
import 'dart:math' as math;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // --- KONFIGURASI DIMENSI NAV BAR ---
  static const double notchRadius = 25.0;
  static const double navBarBaseHeight = 60.0;
  static const double notchHeight = 18.0;
  final double navBarStackHeight = navBarBaseHeight + notchHeight;

  final Color primaryBlue = const Color(0xFF2B3A67);
  final Color accentGold = const Color(0xFFC69931);

  // Daftar Halaman
  late final List<Widget> _pages = [
    const DashboardPage(),                      // Indeks 0
    const PlaceholderPage(title: "Info Pajak"), // Indeks 1
    const PayPage(),                            // Indeks 2
    const KartuDigitalContent(),                // Indeks 3 (Kartu Digital NPWP.jpg)
    const ProfileContent(),                     // Indeks 4 (Profil Rafa.jpg)
  ];

  // Daftar Ikon Navigasi
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_outlined, 'label': "Home"},
    {'icon': Icons.info_outline, 'label': "Info Pajak"},
    {'icon': Icons.credit_card_outlined, 'label': "Bayar", 'badge': true},
    {'icon': Icons.article_outlined, 'label': "Kartu Digital"},
    {'icon': Icons.person_outline, 'label': "Profil"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / 5;
    final double centerActiveX = (_selectedIndex + 0.5) * itemWidth;
    final IconData activeIcon = _navItems[_selectedIndex]['icon'];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        height: navBarStackHeight,
        color: Colors.transparent,
        child: Stack(
          children: [
            // 1. Background Biru Custom Paint
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(screenWidth, navBarBaseHeight),
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
                    children: List.generate(5, (index) {
                      return _buildNavItemCustom(
                        _navItems[index]['icon'],
                        _navItems[index]['label'],
                        index,
                        showRpBadge: _navItems[index]['badge'] ?? false,
                      );
                    }),
                  ),
                ),
              ),
            ),
            // 2. Lingkaran Putih Floating
            Positioned(
              bottom: navBarBaseHeight - (notchRadius + 10.0),
              left: centerActiveX - notchRadius,
              child: _buildActiveCircle(activeIcon),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER NAVIGASI ---
  Widget _buildNavItemCustom(IconData icon, String label, int index, {bool showRpBadge = false}) {
    final bool isSelected = index == _selectedIndex;
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
                if (!isSelected) ...[
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Icon(icon, color: Colors.white, size: 24),
                      if (showRpBadge)
                        Positioned(
                          right: 0, top: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(color: accentGold, borderRadius: BorderRadius.circular(6)),
                            child: const Text("Rp.", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  ),
                ] else ...[
                  const SizedBox(height: 20),
                ],
                const SizedBox(height: 4),
                Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveCircle(IconData icon) {
    return Container(
      width: notchRadius * 2,
      height: notchRadius * 2,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Center(child: Icon(icon, color: primaryBlue, size: 30)),
    );
  }
}

// ==========================================================
// HALAMAN KARTU DIGITAL (MEMANGGIL NPWP.jpg)
// ==========================================================
class KartuDigitalContent extends StatelessWidget {
  const KartuDigitalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient Tipis
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.yellow.withOpacity(0.2), Colors.transparent],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  // Judul Halaman
                  const Text(
                    "Kartu Digital Anda",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- GAMBAR KARTU NPWP ---
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // Transparan agar tidak ada border putih
                      borderRadius: BorderRadius.circular(16),
                      // Shadow dihapus/diminimalisir jika mengganggu tampilan contain
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/NPWP.jpg'),
                        // PENTING: Ganti ke BoxFit.contain agar gambar utuh (tidak terpotong)
                        fit: BoxFit.contain, 
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- STATUS PEMBAYARAN PAJAK ---
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        "Status Pajak",
                        style: TextStyle(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Status Pembayaran Pajak",
                          style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B6B), // Warna Merah Muda/Salmon
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Belum Lunas",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- LIST DATA LAINNYA ---
                  _buildInfoField("Segmen Peserta", "Pajak Perorangan"),
                  // NAMA PERUSAHAAN DIUBAH DI SINI
                  _buildInfoField("Perusahaan Tempat Bekerja", "CV. SAE MITRA SEJATI"), 
                  _buildInfoField("Pembayaran Berikutnya", "10 Agustus 2026"),
                  _buildInfoField("Pembayaran Terakhir", "10 Agustus 2025"),

                  const SizedBox(height: 100), // Spacer Bottom Nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk Kotak Info Biasa
  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================================
// HALAMAN PROFIL (YANG SEBELUMNYA SUDAH ADA)
// ==========================================================
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Gradient
          Positioned(
            top: -50, right: -50,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [Colors.yellow.withOpacity(0.3), Colors.purple.withOpacity(0.1), Colors.transparent]),
              ),
            ),
          ),
          Positioned(
            top: -30, left: -30,
            child: Container(
              width: 150, height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [Colors.blue.withOpacity(0.2), Colors.transparent]),
              ),
            ),
          ),
          // Konten Profil
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                children: [
                  const Align(alignment: Alignment.topRight, child: Icon(Icons.hexagon_outlined, color: Color(0xFF2B3A67), size: 32)),
                  const SizedBox(height: 10),
                  // FOTO PROFIL (Rafa.jpg)
                  Container(
                    width: 130, height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/rafa.jpg'), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Agus Hengker", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Ubah Profil", style: TextStyle(color: Color(0xFFC69931), fontWeight: FontWeight.w600, fontSize: 14)),
                        SizedBox(width: 4),
                        Icon(Icons.edit, size: 14, color: Color(0xFFC69931)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildProfileField("NIK", "1234567812349098"),
                  _buildProfileField("NPWP", "12.129.1293.1-777.999"),
                  _buildProfileField("Email", "agushengkerperopesional@gmail.com"),
                  _buildProfileField("Nomor Telepon", "088237847162"),
                  const SizedBox(height: 100), 
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
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

// --- CUSTOM PAINTER NAVBAR ---
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
    if (startCurveX > 0 && endCurveX < size.width) {
      path.cubicTo(startCurveX + controlPointX1, 0, notchCenter - controlPointX2, peakY, notchCenter, peakY);
      path.cubicTo(notchCenter + controlPointX2, peakY, endCurveX - controlPointX1, 0, endCurveX, 0);
    }
    path.lineTo(size.width, 0);
    path.lineTo(size.width, barHeight);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BottomNavPainterSelected oldDelegate) => oldDelegate.notchCenter != notchCenter;
}

// Placeholder Sederhana
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: const Color(0xFF2B3A67), foregroundColor: Colors.white),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 20))),
    );
  }
}