import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'pay_page.dart';
import 'dart:math' as math;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // --- KONFIGURASI DIMENSI (Sesuai homepakenavbarbtul.dart) ---
  static const double notchRadius = 25.0;
  static const double navBarBaseHeight = 60.0;
  static const double notchHeight = 18.0;
  final double navBarStackHeight = navBarBaseHeight + notchHeight;

  final Color primaryBlue = const Color(0xFF2B3A67);
  final Color accentGold = const Color(0xFFC69931);

  // Daftar Halaman
  final List<Widget> _pages = [
    const DashboardPage(), // Indeks 0
    const PlaceholderPage(title: "Info Pajak"), // Indeks 1
    const PayPage(),       // Indeks 2
    const PlaceholderPage(title: "Kartu Digital"), // Indeks 3
    const PlaceholderPage(title: "Profil"), // Indeks 4
  ];

  // Daftar Ikon dan Label (Ditambah properti badge)
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
      // Menggunakan IndexedStack agar state halaman (seperti scroll) tidak hilang
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
            // 1. Background Biru dengan Notch Cembung
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
            // 2. Lingkaran Putih Aktif (Floating)
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

  // Fungsi pembuat item navigasi (Sesuai logika dashboard)
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
                              style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                ] else ...[
                  const SizedBox(height: 20), // Spacer untuk memberi ruang lingkaran di atas
                ],
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Lingkaran Putih & Ikon Navigasi Aktif
  Widget _buildActiveCircle(IconData icon) {
    return Container(
      width: notchRadius * 2,
      height: notchRadius * 2,
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
        child: Icon(icon, color: primaryBlue, size: 30),
      ),
    );
  }
}

// --- CUSTOM PAINTER (Pindahkan ke sini agar tidak error) ---
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

// Placeholder untuk halaman yang belum dibuat
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