import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/artwork_model.dart';
import '../services/api.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() =>
      _GalleryScreenState();
}

class _GalleryScreenState
    extends State<GalleryScreen> {
      final Set<int> hoveredArtworks = {};
  late Future<List<ArtworkModel>> artworksFuture;

  @override
  void initState() {
    super.initState();

    // نحفظ الـFuture حتى لا يعاد طلب البيانات
    // مع كل rebuild.
    artworksFuture = loadArtworks();
  }

  Future<List<ArtworkModel>>
      loadArtworks() async {
    List<ArtworkModel> artworks =
        await Api().getData();

    // حذف لوحة Cupid and Psyche من العرض.
    // رقم اللوحة في الـAPI هو 138464.
    artworks.removeWhere(
      (artwork) =>
          artwork.id == 138464 ||
          artwork.imageUrl.isEmpty,
    );

    // خلط القائمة مرة واحدة عند فتح الشاشة.
    // أول لوحة بعد الخلط ستكون اللوحة المميزة.
    artworks.shuffle();

    return artworks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF3A0F1E),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF260913),
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
            image: AssetImage(
              "assets/images/musea_wallpaper.png",
            ),
            fit: BoxFit.cover,
          ),
        ),

        child:
            FutureBuilder<List<ArtworkModel>>(
          future: artworksFuture,

          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child:
                    CircularProgressIndicator(
                  color: Color(0xFFC6A15B),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Container(
                  margin:
                      const EdgeInsets.all(24),
                  padding:
                      const EdgeInsets.all(20),
                  color:
                      const Color(0xFFFFF9EF),

                  child: Text(
                    "Failed to load artworks\n"
                    "${snapshot.error}",
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color:
                          Color(0xFF3A0F1E),
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }

            if (!snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No artworks found",
                  style: TextStyle(
                    color:
                        Color(0xFFFFF9EF),
                    fontSize: 17,
                  ),
                ),
              );
            }

            List<ArtworkModel> artworks =
                snapshot.data!;

            // أول لوحة ستكون اللوحة المميزة.
            ArtworkModel featuredArtwork =
                artworks.first;

            // بقية اللوحات ستظهر في المعرض.
            List<ArtworkModel>
                galleryArtworks =
                artworks.skip(1).toList();

            return ListView(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 25,
              ),

              children: [
                // عنوان اللوحة المميزة.
                buildSectionTitle(
                  "ARTWORK OF THE MOMENT",
                ),

                const SizedBox(height: 20),

                // إطار اللوحة المميزة.
                buildArtworkFrame(
                  featuredArtwork,
                ),

                const SizedBox(height: 15),

                // معلومات اللوحة المميزة.
                buildArtworkInformation(
                  featuredArtwork,
                  isFeatured: true,
                ),

                const SizedBox(height: 45),

                // عنوان بقية المعرض.
                buildSectionTitle(
                  "CURATED GALLERY",
                ),

                const SizedBox(height: 25),

                // عرض بقية اللوحات.
                ...galleryArtworks.map(
                  (artwork) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 38,
                      ),

                      child: Column(
                        children: [
                          buildArtworkFrame(
                            artwork,
                          ),

                          const SizedBox(
                            height: 14,
                          ),

                          buildArtworkInformation(
                            artwork,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // يبني العنوان المزخرف بين خطين ذهبيين.
  Widget buildSectionTitle(String title) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFC6A15B),
            thickness: 1,
          ),
        ),

        Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
          ),

          child: Text(
            title,
            textAlign: TextAlign.center,

            style: GoogleFonts.cinzel(
              color:
                  const Color(0xFFE2C477),
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),

        const Expanded(
          child: Divider(
            color: Color(0xFFC6A15B),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  // يبني الإطار الذهبي متعدد الطبقات.
  Widget buildArtworkFrame(
    ArtworkModel artwork,
  ) {
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

        border: Border.all(
          color: const Color(0xFF402507),
          width: 2,
        ),

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

          border: Border.all(
            color: const Color(0xFFFFE7A3),
            width: 1.5,
          ),
        ),

        child: Container(
          padding: const EdgeInsets.all(4),
          color: const Color(0xFF20150F),

          child: Image.network(
            artwork.imageUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,

            loadingBuilder: (
              context,
              child,
              loadingProgress,
            ) {
              if (loadingProgress == null) {
                return child;
              }

              return const SizedBox(
                height: 280,

                child: Center(
                  child:
                      CircularProgressIndicator(
                    color:
                        Color(0xFFC6A15B),
                  ),
                ),
              );
            },

            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return const SizedBox(
                height: 280,

                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color:
                        Color(0xFFC6A15B),
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

  // يبني لوحة المعلومات المزخرفة.
  Widget buildArtworkInformation(
  ArtworkModel artwork, {
  bool isFeatured = false,
}) {
  return Align(
    alignment: Alignment.center,

    child: Container(
      width: MediaQuery.sizeOf(context).width *
          (isFeatured ? 0.72 : 0.68),

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 11,
      ),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Color(0xFFE8CF8A),
            Color(0xFFC6A15B),
            Color(0xFFDCBE73),
          ],
        ),

        border: Border.all(
          color: const Color(0xFF684313),
          width: 2,
        ),

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