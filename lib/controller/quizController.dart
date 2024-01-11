import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/credentials.dart';

import '../entities/quizQuestion.dart';
import '../repository/quizRepository.dart';

class QuizController {
  late QuizRepository quizRepository;
  late QuizQuestion currentQuestion;

  QuizController() {
    quizRepository = QuizRepository();
    currentQuestion = QuizQuestion(
      question: "question",
      hasAttachment: false,
      answerDescription: "answerDescription",
      answerType: "answerType",
      answerChoices: ["answerChoices", "", "", ""],
      correctAnswer: "correctAnswer",
      difficulty: "",
    );
  }

  int _currentQuestionIndex = 0;
  int _score = 0;
  int selectedIndex = -1;
  int correctIndex = -1;
  bool isLastQuestion = false;
  String currentQuestionSelectedAnswer = "";
  List<QuizQuestion> questionList = [];
  Map<dynamic, dynamic> _markingScheme = {};

  void selectAnswer(String answer) {
    currentQuestionSelectedAnswer = answer;
  }

  int validateAnswer() {
    if (currentQuestionSelectedAnswer == currentQuestion.correctAnswer) {
      _score += _markingScheme[currentQuestion.difficulty]! as int;
    }
    int correctIndex =
        currentQuestion.answerChoices.indexOf(currentQuestion.correctAnswer);

    return correctIndex;
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
    resetSelection();
    if (_currentQuestionIndex < questionList.length - 1) {
      _currentQuestionIndex++;
      currentQuestion = questionList[_currentQuestionIndex];
    }
    if (_currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }
  }

  void resetSelection() {
    selectedIndex = -1;
    correctIndex = -1;
    currentQuestionSelectedAnswer = "";
  }

// Initialize questions in the controller, e.g., in the constructor
  Future<void> initializeQuestions() async {
    var questions = await quizRepository.getQuestions();
    await getMarkingScheme();
    questionList = questions;
    currentQuestion = questions[0];
  }

  Future<void> getMarkingScheme() async {
    var response =
        await http.get(Uri.parse("${BASE_URL}/quizQuestion/getMarkingScheme"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _markingScheme = data["data"];
    }
  }
}
