import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/saved_artworks.dart';
import '../models/artwork_details_model.dart';
import '../services/api.dart';

class ArtworkDetailsScreen extends StatefulWidget {
  final int artworkId;

  const ArtworkDetailsScreen({super.key, required this.artworkId});

  @override
  State<ArtworkDetailsScreen> createState() => _ArtworkDetailsScreenState();
}

class _ArtworkDetailsScreenState extends State<ArtworkDetailsScreen> {
  late Future<ArtworkDetailsModel> detailsFuture;

  @override
  void initState() {
    super.initState();

    detailsFuture = Api().getArtworkDetails(widget.artworkId);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF260913),
      ),

      child: Scaffold(
        backgroundColor: const Color(0xFF3A0F1E),

        body: Container(
          width: double.infinity,
          height: double.infinity,

          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/musea_wallpaper.png"),
              fit: BoxFit.cover,
            ),
          ),

          child: SafeArea(
            child: Column(
              children: [
                buildHeader(),

                Expanded(
                  child: FutureBuilder<ArtworkDetailsModel>(
                    future: detailsFuture,

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFC6A15B),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.all(25),
                            padding: const EdgeInsets.all(18),

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
                              "Unable to load artwork details.\n"
                              "Please try again.",
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

                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text(
                            "No details found",
                            style: TextStyle(color: Color(0xFFFFF7E8)),
                          ),
                        );
                      }

                      ArtworkDetailsModel artwork = snapshot.data!;

                      return buildDetailsContent(artwork);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),

      child: SizedBox(
        height: 58,

        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,

              decoration: const BoxDecoration(
                color: Color(0xFFE8CF8A),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 7,
                    offset: Offset(0, 4),
                  ),
                ],
              ),

              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF3A0F1E),
                  size: 26,
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: Text(
                  "MUSEA",
                  style: GoogleFonts.cinzel(
                    color: const Color(0xFFC6A15B),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 46),
          ],
        ),
      ),
    );
  }

  Widget buildDetailsContent(ArtworkDetailsModel artwork) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildArtworkFrame(artwork.imageUrl),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),

            decoration: BoxDecoration(
              color: const Color(0xFFFFF7E8),
              border: Border.all(color: const Color(0xFFC6A15B), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            artwork.title,
                            style: GoogleFonts.cormorantGaramond(
                              color: const Color(0xFF3A0F1E),
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            artwork.artistDisplay,
                            style: GoogleFonts.cormorantGaramond(
                              color: const Color(0xFF3B3029),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            artwork.dateDisplay,
                            style: GoogleFonts.cinzel(
                              color: const Color(0xFF9B6A23),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    ValueListenableBuilder<List<ArtworkDetailsModel>>(
                      valueListenable: savedArtworksNotifier,

                      builder: (context, savedArtworks, child) {
                        bool saved = savedArtworks.any(
                          (savedArtwork) => savedArtwork.id == artwork.id,
                        );

                        return Container(
                          width: 46,
                          height: 46,

                          decoration: const BoxDecoration(
                            color: Color(0xFFE8CF8A),
                            shape: BoxShape.circle,
                          ),

                          child: IconButton(
                            tooltip: saved
                                ? "Remove from Gallery"
                                : "Save to Gallery",

                            onPressed: () {
                              toggleSavedArtwork(artwork);

                              ScaffoldMessenger.of(
                                context,
                              ).hideCurrentSnackBar();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: const Color(0xFF260913),
                                  content: Text(
                                    saved
                                        ? "Removed from Gallery"
                                        : "Saved to Gallery",
                                    style: const TextStyle(
                                      color: Color(0xFFE8CF8A),
                                    ),
                                  ),
                                ),
                              );
                            },

                            icon: Icon(
                              saved ? Icons.bookmark : Icons.bookmark_border,
                              color: const Color(0xFF3A0F1E),
                              size: 26,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                const Divider(color: Color(0xFFC6A15B), thickness: 1),

                const SizedBox(height: 10),

                buildInformationRow(
                  icon: Icons.brush_outlined,
                  title: "Technique",
                  value: artwork.technique,
                ),

                buildInformationRow(
                  icon: Icons.straighten_outlined,
                  title: "Measurements",
                  value: artwork.measurements,
                ),

                buildInformationRow(
                  icon: Icons.account_balance_outlined,
                  title: "Department",
                  value: artwork.department,
                ),

                buildInformationRow(
                  icon: Icons.public_outlined,
                  title: "Culture",
                  value: artwork.culture,
                ),

                const SizedBox(height: 3),

                Text(
                  "About this artwork",
                  style: GoogleFonts.cormorantGaramond(
                    color: const Color(0xFF3A0F1E),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  artwork.description,
                  style: const TextStyle(
                    color: Color(0xFF352D28),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArtworkFrame(String imageUrl) {
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
            offset: Offset(0, 9),
          ),
        ],
      ),

      child: Container(
        padding: const EdgeInsets.all(7),

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

          child: imageUrl.isEmpty
              ? const SizedBox(
                  height: 250,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Color(0xFFC6A15B),
                      size: 50,
                    ),
                  ),
                )
              : Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const SizedBox(
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFC6A15B),
                        ),
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

  Widget buildInformationRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: 36,
            height: 36,

            decoration: const BoxDecoration(
              color: Color(0xFFE8CF8A),
              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: const Color(0xFF3A0F1E), size: 19),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF8B7466),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF3A0F1E),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
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
