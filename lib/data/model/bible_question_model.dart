class BibleQuestionModel {
  String question;
  String answer;

  BibleQuestionModel({
    required this.question,
    required this.answer,
  });

  factory BibleQuestionModel.fromJson(Map<String, dynamic> json) {
    return BibleQuestionModel(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
      };
}
