class QuizQuestion {
  final String question;
  final bool hasAttachment;
  final String? attachmentType;
  final String answerType;
  final String? attachment;
  final List<String> answerChoices;
  final String correctAnswer;

  QuizQuestion({
    required this.question,
    required this.hasAttachment,
    this.attachmentType,
    this.attachment,
    required this.answerType,
    required this.answerChoices,
    required this.correctAnswer,
  });
}
