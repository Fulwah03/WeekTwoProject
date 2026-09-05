import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/artwork_model.dart';
import '../services/api.dart';
import 'artwork_details_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  static const int excludedArtworkId = 138464;

  late Future<List<ArtworkModel>> artworksFuture;

  @override
  void initState() {
    super.initState();
    artworksFuture = loadArtworks();
  }

  Future<List<ArtworkModel>> loadArtworks() async {
    List<ArtworkModel> artworks = await Api().getData();

    artworks.removeWhere(
      (artwork) => artwork.id == excludedArtworkId || artwork.imageUrl.isEmpty,
    );

    artworks.shuffle();

    return artworks;
  }

  void openArtworkDetails(ArtworkModel artwork) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ArtworkDetailsScreen(artworkId: artwork.id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A0F1E),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF260913),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "MUSEA",
          style: GoogleFonts.cinzel(
            color: const Color(0xFFC6A15B),
            fontSize: 24,
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

        child: FutureBuilder<List<ArtworkModel>>(
          future: artworksFuture,

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFC6A15B)),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7E8),
                    border: Border.all(
                      color: const Color(0xFFC6A15B),
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Unable to load artworks.\n"
                    "Please check your internet connection.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3A0F1E),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No artworks found",
                  style: TextStyle(color: Color(0xFFFFF7E8), fontSize: 17),
                ),
              );
            }

            List<ArtworkModel> artworks = snapshot.data!;

            ArtworkModel featuredArtwork = artworks.first;

            List<ArtworkModel> galleryArtworks = artworks.skip(1).toList();

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),

              children: [
                buildSectionTitle("ARTWORK OF THE MOMENT"),

                const SizedBox(height: 20),

                GestureDetector(
                  behavior: HitTestBehavior.opaque,

                  onTap: () {
                    openArtworkDetails(featuredArtwork);
                  },

                  child: Column(
                    children: [
                      buildArtworkFrame(featuredArtwork),
                      const SizedBox(height: 15),
                      buildArtworkInformation(
                        featuredArtwork,
                        isFeatured: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 45),

                buildSectionTitle("CURATED GALLERY"),

                const SizedBox(height: 25),

                ...galleryArtworks.map((artwork) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,

                    onTap: () {
                      openArtworkDetails(artwork);
                    },

                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 38),

                      child: Column(
                        children: [
                          buildArtworkFrame(artwork),
                          const SizedBox(height: 14),
                          buildArtworkInformation(artwork),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFC6A15B), thickness: 1)),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              color: const Color(0xFFE2C477),
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),

        const Expanded(child: Divider(color: Color(0xFFC6A15B), thickness: 1)),
      ],
    );
  }

  Widget buildArtworkFrame(ArtworkModel artwork) {
    return Container(
      padding: const EdgeInsets.all(4),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF55300B),
            Color(0xFFF2D68A),
            Color(0xFF9C6A20),
            Color(0xFFE5C16A),
            Color(0xFF59360E),
          ],
        ),

        border: Border.all(color: const Color(0xFF402507), width: 2),

        boxShadow: const [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 16,
            offset: Offset(0, 10),
          ),
        ],
      ),

      child: Container(
        padding: const EdgeInsets.all(8),

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE8A8),
              Color(0xFFBD8731),
              Color(0xFF6B4313),
              Color(0xFFE9C96F),
            ],
          ),

          border: Border.all(color: const Color(0xFFFFE7A3), width: 1.5),
        ),

        child: Container(
          padding: const EdgeInsets.all(4),
          color: const Color(0xFF20150F),

          child: Image.network(
            artwork.imageUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,

            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return const SizedBox(
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFFC6A15B)),
                ),
              );
            },

            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(
                height: 250,
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: Color(0xFFC6A15B),
                    size: 50,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildArtworkInformation(
    ArtworkModel artwork, {
    bool isFeatured = false,
  }) {
    return Align(
      alignment: Alignment.center,

      child: Container(
        width: MediaQuery.sizeOf(context).width * (isFeatured ? 0.72 : 0.68),

        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),

        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8CF8A), Color(0xFFC6A15B), Color(0xFFDCBE73)],
          ),

          border: Border.all(color: const Color(0xFF684313), width: 2),

          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              artwork.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cormorantGaramond(
                color: const Color(0xFF3A0F1E),
                fontSize: isFeatured ? 22 : 20,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              artwork.artistDisplay,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cormorantGaramond(
                color: const Color(0xFF35200F),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              artwork.dateDisplay,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cinzel(
                color: const Color(0xFF6A4012),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
