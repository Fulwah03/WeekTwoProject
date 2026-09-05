import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const Color burgundy = Color(0xFF3A0F1E);
  static const Color darkBurgundy = Color(0xFF260913);
  static const Color gold = Color(0xFFC6A15B);
  static const Color lightGold = Color(0xFFE8CF8A);
  static const Color ivory = Color(0xFFFFF7E8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: burgundy,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBurgundy,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: Text(
          "MUSEA",
          style: GoogleFonts.cinzel(
            color: gold,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/musea_wallpaper.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 28, 22, 30),

          child: Column(
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/musea_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "ABOUT MUSEA",
                textAlign: TextAlign.center,

                style: GoogleFonts.cinzel(
                  color: lightGold,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "ART WITHOUT WALLS",
                textAlign: TextAlign.center,

                style: GoogleFonts.cinzel(
                  color: gold,
                  fontSize: 12,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 20),

              buildDivider(),

              const SizedBox(height: 22),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: ivory,

                  border: Border.all(color: gold, width: 2),

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 14,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    buildSectionTitle("WELCOME TO MUSEA"),

                    const SizedBox(height: 12),

                    Text(
                      "MUSEA is a digital museum experience "
                      "that allows you to discover remarkable "
                      "artworks and learn the stories behind them.",
                      style: GoogleFonts.cormorantGaramond(
                        color: const Color(0xFF3B3029),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Divider(color: gold, thickness: 1),

                    const SizedBox(height: 18),

                    buildSectionTitle("WHAT YOU CAN DO"),

                    const SizedBox(height: 16),

                    buildFeature(
                      icon: Icons.explore_outlined,
                      title: "Discover Artworks",
                      description:
                          "Explore a curated collection of museum artworks.",
                    ),

                    buildFeature(
                      icon: Icons.info_outline,
                      title: "View Artwork Details",
                      description:
                          "Learn about artists, dates, techniques and dimensions.",
                    ),

                    buildFeature(
                      icon: Icons.bookmark_border,
                      title: "Create Your Gallery",
                      description:
                          "Save your favorite artworks in your personal gallery.",
                    ),

                    const SizedBox(height: 8),

                    const Divider(color: gold, thickness: 1),

                    const SizedBox(height: 18),

                    buildSectionTitle("THE COLLECTION"),

                    const SizedBox(height: 12),

                    Text(
                      "Artwork information and images are "
                      "provided through the Cleveland Museum "
                      "of Art Open Access API.",
                      style: GoogleFonts.cormorantGaramond(
                        color: const Color(0xFF3B3029),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 13,
                ),

                decoration: BoxDecoration(
                  color: lightGold,
                  border: Border.all(color: gold, width: 2),
                ),

                child: Column(
                  children: [
                    Text(
                      "DESIGNED & DEVELOPED BY",
                      style: GoogleFonts.cinzel(
                        color: burgundy,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "FULWAH",
                      style: GoogleFonts.cinzel(
                        color: burgundy,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: gold, thickness: 1)),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Icon(Icons.diamond, color: lightGold, size: 13),
        ),

        const Expanded(child: Divider(color: gold, thickness: 1)),
      ],
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cinzel(
        color: burgundy,
        fontSize: 17,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget buildFeature({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: 42,
            height: 42,

            decoration: const BoxDecoration(
              color: lightGold,
              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: burgundy, size: 21),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    color: burgundy,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF65564E),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
