import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'about_screen.dart';
import 'gallery_screen.dart';
import 'saved_gallery_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    GalleryScreen(),
    SavedGalleryScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A0F1E),

      body: IndexedStack(index: _selectedIndex, children: _pages),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,

        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF260913),
        selectedItemColor: const Color(0xFFE2C477),
        unselectedItemColor: const Color(0xFF8F7161),
        selectedFontSize: 11,
        unselectedFontSize: 10,

        selectedLabelStyle: GoogleFonts.cinzel(fontWeight: FontWeight.bold),

        unselectedLabelStyle: GoogleFonts.cinzel(),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: "Discover",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined),
            activeIcon: Icon(Icons.photo_library),
            label: "Gallery",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            activeIcon: Icon(Icons.account_balance),
            label: "About",
          ),
        ],
      ),
    );
  }
}
