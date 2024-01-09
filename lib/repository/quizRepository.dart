import '../entities/quizQuestion.dart';

class QuizRepository {
  List<QuizQuestion> getQuestions() {
    //TODO: Fetch questions from an API, database, or local source
    return [
      QuizQuestion(
          question: 'What is the capital of France?',
          answerChoices: ['Paris', 'London', 'Berlin', 'Madrid'],
          correctAnswer: 'Paris',
          hasAttachment: false,
          answerType: "text",
          answerDescription: "Lorem Ipsum"),
      QuizQuestion(
          question: 'Which planet is known as the Red Planet?',
          answerChoices: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
          correctAnswer: 'Mars',
          hasAttachment: false,
          answerType: "text",
          answerDescription: "Lorem Ipsum"),
      // Add more questions here
    ];
  }
}
