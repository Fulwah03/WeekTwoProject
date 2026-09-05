import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/saved_artworks.dart';
import '../models/artwork_details_model.dart';
import 'artwork_details_screen.dart';

class SavedGalleryScreen extends StatelessWidget {
  const SavedGalleryScreen({super.key});

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

        child: ValueListenableBuilder<List<ArtworkDetailsModel>>(
          valueListenable: savedArtworksNotifier,

          builder: (context, savedArtworks, child) {
            if (savedArtworks.isEmpty) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(28),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bookmark_border,
                        color: Color(0xFF3A0F1E),
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Your Gallery is Empty",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          color: const Color(0xFF3A0F1E),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        "Save artworks to see them here.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6B584D),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    "MY GALLERY",
                    style: GoogleFonts.cinzel(
                      color: const Color(0xFFE2C477),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: savedArtworks.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 18,
                          childAspectRatio: 0.58,
                        ),

                    itemBuilder: (context, index) {
                      ArtworkDetailsModel artwork = savedArtworks[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ArtworkDetailsScreen(
                                  artworkId: artwork.id,
                                );
                              },
                            ),
                          );
                        },

                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC6A15B),
                            border: Border.all(
                              color: const Color(0xFFFFE7A3),
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 9,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),

                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  color: const Color(0xFF20150F),

                                  child: Image.network(
                                    artwork.imageUrl,
                                    fit: BoxFit.cover,

                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }

                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Color(0xFFC6A15B),
                                            ),
                                          );
                                        },

                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(
                                          Icons.broken_image_outlined,
                                          color: Color(0xFFC6A15B),
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              Container(
                                width: double.infinity,
                                height: 105,
                                padding: const EdgeInsets.all(8),
                                color: const Color(0xFFFFF7E8),

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      artwork.title,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.cormorantGaramond(
                                        color: const Color(0xFF3A0F1E),
                                        fontSize: 16,
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
                                      style: const TextStyle(
                                        color: Color(0xFF4C4039),
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      artwork.dateDisplay,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xFF9B6A23),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
