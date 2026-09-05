import 'package:flutter/foundation.dart';

import '../models/artwork_details_model.dart';

final ValueNotifier<List<ArtworkDetailsModel>> savedArtworksNotifier =
    ValueNotifier<List<ArtworkDetailsModel>>(<ArtworkDetailsModel>[]);

void toggleSavedArtwork(ArtworkDetailsModel artwork) {
  final List<ArtworkDetailsModel> updatedList = List<ArtworkDetailsModel>.from(
    savedArtworksNotifier.value,
  );

  final int savedIndex = updatedList.indexWhere(
    (savedArtwork) => savedArtwork.id == artwork.id,
  );

  if (savedIndex == -1) {
    updatedList.add(artwork);
  } else {
    updatedList.removeAt(savedIndex);
  }

  savedArtworksNotifier.value = updatedList;
}
