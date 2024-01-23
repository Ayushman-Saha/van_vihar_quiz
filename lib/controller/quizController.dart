import 'package:geolocator/geolocator.dart';
import 'package:van_vihar_quiz/entities/quizDetailsData.dart';

import '../entities/quizQuestion.dart';
import '../repository/quizRepository.dart';

class QuizController {
  late QuizRepository quizRepository;
  late QuizQuestion currentQuestion;
  late QuizDetailsData _quizDetails;

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
      id: "",
    );
  }

  int _currentQuestionIndex = 1;
  int _score = 0;

  int selectedIndex = -1;
  int correctIndex = -1;

  int typeAttempts = 0;
  String currentType = "easy";

  bool isLastQuestion = false;
  String currentQuestionSelectedAnswer = "";

  Map numberOfAttempts = {"easy": 4, "medium": 3, "hard": 3};

  Map<String, List<QuizQuestion>> questionList = {};

  late List<String> _attemptedQuestionIds = [];
  late List<String> _correctAttemptedQuestionIds = [];

  void selectAnswer(String answer) {
    currentQuestionSelectedAnswer = answer;
  }

  List<String> getCorrectAttemptedQuestionIds() {
    return _correctAttemptedQuestionIds;
  }

  List<String> getAttemptedQuestionIds() {
    return _attemptedQuestionIds;
  }

  int getTimeLimit() {
    return _quizDetails.timeLimit;
  }

  int validateAnswer() {
    _attemptedQuestionIds.add(currentQuestion.id);
    if (currentQuestionSelectedAnswer == currentQuestion.correctAnswer) {
      if (currentQuestion.difficulty == "easy") {
        _score += _quizDetails.marksEasy;
      }
      if (currentQuestion.difficulty == "medium") {
        _score += _quizDetails.marksMedium;
      }
      if (currentQuestion.difficulty == "hard") {
        _score += _quizDetails.marksHard;
      }
      _correctAttemptedQuestionIds.add(currentQuestion.id);
    }
    int correctIndex =
        currentQuestion.answerChoices.indexOf(currentQuestion.correctAnswer);

    return correctIndex;
  }

  int getCurrentIndex() {
    return _currentQuestionIndex;
  }

  int getTotalQuestions() {
    return _quizDetails.questionCount;
  }

  int getScore() {
    return _score;
  }

  bool isGeofenceCrossed(double lat, double long) {
    if (_quizDetails.isGeofenceEnabled) {
      var distance = Geolocator.distanceBetween(
          lat, long, _quizDetails.limitLatitude, _quizDetails.limitLongitude);
      if (distance <= _quizDetails.range) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  void nextQuestion() {
    resetSelection();
    if (_currentQuestionIndex < _quizDetails.questionCount) {
      _currentQuestionIndex++;
      typeAttempts++;
      if (typeAttempts < numberOfAttempts[currentType]) {
        currentQuestion = questionList[currentType]![typeAttempts];
      } else {
        nextType(currentType);
        typeAttempts = 0;
        currentQuestion = questionList[currentType]![typeAttempts];
      }
    }
    if (_currentQuestionIndex == _quizDetails.questionCount &&
        currentType == "hard") {
      isLastQuestion = true;
    }
  }

  void nextType(String type) {
    if (type == "easy") {
      currentType = "medium";
    }
    if (type == "medium") {
      currentType = "hard";
    }
  }

  void resetSelection() {
    selectedIndex = -1;
    correctIndex = -1;
    currentQuestionSelectedAnswer = "";
  }

  void _clearData() {
    selectedIndex = -1;
    correctIndex = -1;
    currentQuestionSelectedAnswer = "";

    currentQuestion = QuizQuestion(
      question: "question",
      hasAttachment: false,
      answerDescription: "answerDescription",
      answerType: "answerType",
      answerChoices: ["answerChoices", "", "", ""],
      correctAnswer: "correctAnswer",
      difficulty: "",
      id: "",
    );

    _currentQuestionIndex = 1;
    _score = 0;

    typeAttempts = 0;
    currentType = "easy";

    isLastQuestion = false;

    questionList = {};

    _attemptedQuestionIds = [];
    _correctAttemptedQuestionIds = [];
  }

// Initialize questions in the controller, e.g., in the constructor
  Future<bool> initializeQuestions(double lat, double long) async {
    _clearData();
    _quizDetails = await quizRepository.getQuizDetails();
    var questions = await quizRepository.getQuestions(
        _quizDetails.questionCount, _quizDetails.tags);
    questionList = questions;
    currentQuestion = questions[currentType]![0];
    return isGeofenceCrossed(lat, long);
  }
}
