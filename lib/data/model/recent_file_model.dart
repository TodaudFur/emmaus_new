class RecentFileModel {
  String type;
  DateTime createAt;

  RecentFileModel({
    required this.type,
    required this.createAt,
  });

  factory RecentFileModel.fromJson(Map<String, dynamic> json) {
    return RecentFileModel(
      type: json['type'],
      createAt: DateTime.parse(json['createAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'createAt': createAt,
      };
}
