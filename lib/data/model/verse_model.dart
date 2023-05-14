class VerseModel {
  String english;
  String korean;

  VerseModel({
    required this.english,
    required this.korean,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      english: json['english'].toString().replaceAll('\\n', '\n'),
      korean: json['korean'].toString().replaceAll('\\n', '\n'),
    );
  }
  Map<String, dynamic> toJson() => {
        'english': english,
        'korean': korean,
      };
}
