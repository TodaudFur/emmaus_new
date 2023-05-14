class QuestionModel {
  int id;
  String content;
  DateTime date;
  String name;

  QuestionModel(
      {required this.id,
      required this.content,
      required this.date,
      required this.name});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: int.parse(json['id']),
      content: json['content'] ?? "",
      date: DateTime.parse(json['date']),
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {};
}
