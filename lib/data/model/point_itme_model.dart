class PointModel {
  int id;
  String name;
  int price;
  String detailImage;
  String thumbnail;

  PointModel({
    required this.id,
    required this.name,
    required this.price,
    required this.detailImage,
    required this.thumbnail,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      id: int.parse(json['id']),
      name: json['name'],
      price: int.parse(json['price']),
      detailImage: json['detailImage'],
      thumbnail: json['thumbnail'],
    );
  }
}
