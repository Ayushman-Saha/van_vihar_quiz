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
          descriptionAttachment:
              "https://plus.unsplash.com/premium_photo-1661852674235-967247c4a8ed?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
