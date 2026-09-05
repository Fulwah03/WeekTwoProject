import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main_navigation_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF260913),
      ),

      child: Scaffold(
        backgroundColor: const Color(0xFF260913),

        body: Stack(
          fit: StackFit.expand,

          children: [
            Image.asset("assets/images/musea_wallpaper.png", fit: BoxFit.cover),

            Container(color: const Color(0x88260913)),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 24,
                ),

                child: Column(
                  children: [
                    const Spacer(),

                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: 1),

                      duration: const Duration(milliseconds: 1200),

                      curve: Curves.easeOutCubic,

                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,

                          child: Transform.scale(
                            scale: 0.85 + (value * 0.15),
                            child: child,
                          ),
                        );
                      },

                      child: Container(
                        width: 200,
                        height: 200,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 18,
                              offset: Offset(0, 9),
                            ),
                          ],
                        ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: Image.asset(
                            "assets/images/musea_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "WELCOME TO MUSEA",
                      textAlign: TextAlign.center,

                      style: GoogleFonts.cinzel(
                        color: const Color(0xFFE8CF8A),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Row(
                      children: [
                        Expanded(child: Divider(color: Color(0xFFC6A15B))),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),

                          child: Icon(
                            Icons.diamond,
                            color: Color(0xFFE8CF8A),
                            size: 10,
                          ),
                        ),

                        Expanded(child: Divider(color: Color(0xFFC6A15B))),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      "Where every masterpiece tells a story.",
                      textAlign: TextAlign.center,

                      style: GoogleFonts.cormorantGaramond(
                        color: const Color(0xFFFFF7E8),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Step inside and explore a timeless world of art.",
                      textAlign: TextAlign.center,

                      style: GoogleFonts.cormorantGaramond(
                        color: const Color(0xFFE1D2C3),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 54,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const MainNavigationScreen();
                              },
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE8CF8A),

                          foregroundColor: const Color(0xFF3A0F1E),

                          elevation: 8,

                          shadowColor: Colors.black,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),

                            side: const BorderSide(
                              color: Color(0xFFC6A15B),
                              width: 2,
                            ),
                          ),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Icon(
                              Icons.account_balance_outlined,
                              size: 22,
                            ),

                            const SizedBox(width: 10),

                            Text(
                              "ENTER THE MUSEUM",

                              style: GoogleFonts.cinzel(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "A DIGITAL ART EXPERIENCE",
                      style: GoogleFonts.cinzel(
                        color: const Color(0xFFC6A15B),
                        fontSize: 9,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
