import '../entities/quizQuestion.dart';
import '../repository/quizRepository.dart';

class QuizController {
  QuizController() {
    final quizRepository = QuizRepository();
    final questions = quizRepository.getQuestions();
    initializeQuestions(questions);
  }

  int _currentQuestionIndex = 0;
  int _score = 0;
  String currentQuestionSelectedAnswer = "";
  late QuizQuestion currentQuestion;
  late List<QuizQuestion> questionList;

  void selectAnswer(String answer) {
    currentQuestionSelectedAnswer = answer;
  }

  bool validateAnswer() {
    if (currentQuestionSelectedAnswer == currentQuestion.correctAnswer) {
      _score += 5;
    }

    return currentQuestionSelectedAnswer == currentQuestion.correctAnswer;
  }

  int getCurrentIndex() {
    return _currentQuestionIndex + 1;
  }

  int getTotalQuestions() {
    return questionList.length;
  }

  int getScore() {
    return _score;
  }

  void nextQuestion() {
    if (_currentQuestionIndex < questionList.length - 1) {
      _currentQuestionIndex++;
      currentQuestion = questionList[_currentQuestionIndex];
    }
  }

// Initialize questions in the controller, e.g., in the constructor
  void initializeQuestions(List<QuizQuestion> questions) {
    questionList = questions;
    currentQuestion = questions[0];
  }
}
