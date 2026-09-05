class ArtworkModel {
  final int id;
  final String title;
  final String artistDisplay;
  final String dateDisplay;
  final String imageUrl;
  ArtworkModel({
    required this.id,
    required this.title,
    required this.artistDisplay,
    required this.dateDisplay,
    required this.imageUrl,
  });

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    String artistName = "Unknown artist";

    if (json["creators"] != null && json["creators"].isNotEmpty) {
      artistName = json["creators"][0]["description"] ?? "Unknown artist";
    }

    String artworkImage = "";

    if (json["images"] != null && json["images"]["web"] != null) {
      artworkImage = json["images"]["web"]["url"] ?? "";
    }

    return ArtworkModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "Untitled",
      artistDisplay: artistName,
      dateDisplay: json["creation_date"] ?? "Unknown date",
      imageUrl: artworkImage,
    );
  }
}
