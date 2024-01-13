class EndScreenArguments {
  final int score;
  final int timeTaken;
  final List<String> attemptedQuestionIds;
  final List<String> correctAttemptedQuestionIds;

  EndScreenArguments({required this.score, required this.timeTaken, required this.attemptedQuestionIds, required this.correctAttemptedQuestionIds});
}
