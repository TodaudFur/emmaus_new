class PostModel {
  int id;
  String title;
  String content;
  String writer;
  int userId;
  DateTime date;
  int hit;
  bool isSecret;
  int likeCount;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.writer,
    required this.userId,
    required this.date,
    required this.hit,
    required this.isSecret,
    required this.likeCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] == null ? 0 : int.parse(json['id']),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      writer: json['writer'] ?? '',
      userId: json['userId'] == null ? 0 : int.parse(json['userId']),
      date:
          json['date'] == null ? DateTime.now() : DateTime.parse(json['date']),
      hit: json['hit'] == null ? 0 : int.parse(json['hit']),
      isSecret: json['isSecret'] == null
          ? false
          : json['isSecret'] == "1"
              ? true
              : false,
      likeCount: json['likeCount'] == null ? 0 : int.parse(json['likeCount']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'writer': writer,
        'userId': userId,
        'date': date,
        'hit': hit,
        'isSecret': isSecret,
        'likeCount': likeCount,
      };
}
