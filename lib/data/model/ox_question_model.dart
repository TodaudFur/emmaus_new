class OXQuestionModel {
  String question;
  String answer;

  OXQuestionModel({
    required this.question,
    required this.answer,
  });

  factory OXQuestionModel.fromJson(Map<String, dynamic> json) {
    return OXQuestionModel(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
      };
}
