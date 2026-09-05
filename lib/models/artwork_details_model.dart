class ArtworkDetailsModel {
  final int id;
  final String title;
  final String artistDisplay;
  final String dateDisplay;
  final String imageUrl;
  final String description;
  final String technique;
  final String measurements;
  final String department;
  final String culture;

  ArtworkDetailsModel({
    required this.id,
    required this.title,
    required this.artistDisplay,
    required this.dateDisplay,
    required this.imageUrl,
    required this.description,
    required this.technique,
    required this.measurements,
    required this.department,
    required this.culture,
  });

  factory ArtworkDetailsModel.fromJson(Map<String, dynamic> json) {
    String artistName = "Unknown artist";

    var creators = json["creators"];

    if (creators is List && creators.isNotEmpty) {
      var firstCreator = creators[0];

      if (firstCreator is Map && firstCreator["description"] != null) {
        artistName = firstCreator["description"].toString();
      }
    }

    String artworkImage = "";

    var images = json["images"];

    if (images is Map && images["web"] is Map && images["web"]["url"] != null) {
      artworkImage = images["web"]["url"].toString();
    }

    String artworkCulture = "Unknown";

    var cultureData = json["culture"];

    if (cultureData is List && cultureData.isNotEmpty) {
      artworkCulture = cultureData.join(", ");
    }

    String artworkDescription =
        json["description"]?.toString() ?? "No description available.";

    artworkDescription = artworkDescription.replaceAll(RegExp(r"<[^>]*>"), "");

    return ArtworkDetailsModel(
      id: json["id"] ?? 0,

      title: json["title"]?.toString() ?? "Untitled",

      artistDisplay: artistName,

      dateDisplay: json["creation_date"]?.toString() ?? "Unknown date",

      imageUrl: artworkImage,

      description: artworkDescription,

      technique: json["technique"]?.toString() ?? "Not available",

      measurements: json["measurements"]?.toString() ?? "Not available",

      department: json["department"]?.toString() ?? "Not available",

      culture: artworkCulture,
    );
  }
}
