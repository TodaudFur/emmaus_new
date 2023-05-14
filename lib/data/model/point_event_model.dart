class EventModel {
  int id;
  String thumbnail;
  String mainImage;
  String value;

  EventModel({
    required this.id,
    required this.thumbnail,
    required this.mainImage,
    required this.value,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: int.parse(json['id']),
      thumbnail: json['thumbnail'],
      mainImage: json['mainImage'],
      value: json['value'],
    );
  }
}
