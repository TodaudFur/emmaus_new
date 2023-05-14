class LeaderModel {
  String type;
  String name;

  LeaderModel({
    required this.type,
    required this.name,
  });

  factory LeaderModel.fromJson(Map<String, dynamic> json) {
    return LeaderModel(
      type: json['type'],
      name: json['name'],
    );
  }
}
