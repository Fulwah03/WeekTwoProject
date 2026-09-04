import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musea/models/artwork_details.dart';
import 'package:musea/models/artwork_model.dart';



class Api {

 Future<List<ArtworkModel>> getData() async {
  String link =
      "https://openaccess-api.clevelandart.org/api/artworks/"
      "?limit=20&has_image=1";

  Uri uri = Uri.parse(link);

  http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> responseJson =
        jsonDecode(response.body);

    List<ArtworkModel> artworksList = [];

    for (var artwork in responseJson["data"]) {
      artworksList.add(
        ArtworkModel.fromJson(artwork),
      );
    }

    return artworksList;
  } else {
    throw Exception("Failed to load artworks");
  }
}

  Future<ArtworkDetailsModel> getArtworkDetails(
  int artworkId,
) async {
  String link =
      "https://api.artic.edu/api/v1/artworks/$artworkId"
      "?fields=id,title,artist_display,date_display,"
      "medium_display,dimensions,description,image_id,"
      "department_title,place_of_origin";

  Uri uri = Uri.parse(link);

  var response = await http.get(uri);

  if (response.statusCode == 200) {
    var responseBody = response.body;
    var responseJson = jsonDecode(responseBody);

    var artworkData = responseJson["data"];

    ArtworkDetailsModel artworkDetails =
        ArtworkDetailsModel.fromJson(
      artworkData,
    );

    return artworkDetails;
  } else {
    throw Exception(
      "Failed to load artwork details",
    );
  }
}
}