class QuizQuestion {
  final String question;
  final bool hasAttachment;
  final String? attachmentType;
  final String answerType;
  final String? attachment;
  final List<String> answerChoices;
  final String correctAnswer;
  final String answerDescription;
  final String? descriptionAttachment;

  QuizQuestion({
    required this.question,
    required this.hasAttachment,
    this.attachmentType,
    this.attachment,
    required this.answerDescription,
    this.descriptionAttachment,
    required this.answerType,
    required this.answerChoices,
    required this.correctAnswer,
  });
}
