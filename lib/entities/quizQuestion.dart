class QuizQuestion {
  final String question;
  final bool hasAttachment;
  final String? attachmentType;
  final String answerType;
  final String? attachment;
  final List<dynamic> answerChoices;
  final String correctAnswer;
  final String answerDescription;
  final String? descriptionAttachment;
  final String difficulty;
  final String id;

  QuizQuestion(
      {required this.question,
      required this.hasAttachment,
      this.attachmentType,
      this.attachment,
      required this.answerDescription,
      this.descriptionAttachment,
      required this.answerType,
      required this.answerChoices,
      required this.correctAnswer,
      required this.difficulty,
        required this.id
      });

  factory QuizQuestion.fromJson(dynamic json) {
    return QuizQuestion(
      id: json["_id"],
      question: json["question"],
      hasAttachment: json["hasAttachment"],
      answerDescription: json["answerDescription"],
      answerType: json["answerType"],
      answerChoices: json["answerChoices"],
      correctAnswer: json["correctAnswer"],
      attachmentType: json["attachmentType"],
      attachment: json["attachment"],
      descriptionAttachment: json["descriptionAttachment"],
      difficulty: json["difficulty"],
    );
  }
}
