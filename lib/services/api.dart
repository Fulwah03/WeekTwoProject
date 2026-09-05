import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/artwork_model.dart';
import '../models/artwork_details_model.dart';

class Api {
  Future<List<ArtworkModel>> getData() async {
    String link =
        "https://openaccess-api.clevelandart.org/"
        "api/artworks/?limit=20&has_image=1";

    Uri uri = Uri.parse(link);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);

      List<ArtworkModel> artworks = [];

      for (var artwork in responseJson["data"]) {
        artworks.add(ArtworkModel.fromJson(artwork));
      }

      return artworks;
    } else {
      throw Exception("Failed to load artworks");
    }
  }

  Future<ArtworkDetailsModel> getArtworkDetails(int artworkId) async {
    String link =
        "https://openaccess-api.clevelandart.org/"
        "api/artworks/$artworkId/";

    Uri uri = Uri.parse(link);

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = jsonDecode(response.body);

      Map<String, dynamic> artworkData = responseJson["data"];

      return ArtworkDetailsModel.fromJson(artworkData);
    } else {
      throw Exception("Failed to load artwork details");
    }
  }
}
