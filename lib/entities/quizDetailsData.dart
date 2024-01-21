class QuizDetailsData {
  final int questionCount;
  final int marksEasy;
  final int marksMedium;
  final int marksHard;
  final List<dynamic> tags;
  final int timeLimit;

  QuizDetailsData({
    required this.questionCount,
    required this.marksEasy,
    required this.marksMedium,
    required this.marksHard,
    required this.tags,
    required this.timeLimit,
  });

  factory QuizDetailsData.fromJson(dynamic json) {
    return QuizDetailsData(
        questionCount: json["questionCount"],
        marksEasy: json["marksEasy"],
        marksMedium: json["marksMedium"],
        marksHard: json["marksHard"],
        tags: json["tags"],
        timeLimit: json["timeLimit"]);
  }
}
