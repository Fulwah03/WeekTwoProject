class ArtworkDetailsModel {
  int? id;
  String? title;
  String? artistDisplay;
  String? dateDisplay;
  String? imageId;
  String? mediumDisplay;
  String? dimensions;
  String? description;
  String? departmentTitle;
  String? placeOfOrigin;

  ArtworkDetailsModel({
    this.id,
    this.title,
    this.artistDisplay,
    this.dateDisplay,
    this.imageId,
    this.mediumDisplay,
    this.dimensions,
    this.description,
    this.departmentTitle,
    this.placeOfOrigin,
  });

  factory ArtworkDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ArtworkDetailsModel(
      id: json["id"],
      title: json["title"],
      artistDisplay: json["artist_display"],
      dateDisplay: json["date_display"],
      imageId: json["image_id"],
      mediumDisplay: json["medium_display"],
      dimensions: json["dimensions"],
      description: json["description"],
      departmentTitle: json["department_title"],
      placeOfOrigin: json["place_of_origin"],
    );
  }
}