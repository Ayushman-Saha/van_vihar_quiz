import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/credentials.dart';

import '../entities/quizQuestion.dart';

class QuizRepository {
  Future<List<QuizQuestion>> getQuestions() async {
    var response = await http.get(Uri.parse("${BASE_URL}/quizQuestion/get"));
    return _responseToQuizQuestions(response);
  }

  List<QuizQuestion> _responseToQuizQuestions(dynamic response) {
    List<QuizQuestion> questions = [];
    var list = jsonDecode(response.body);
    var questionList = list["data"];
    // print(questionList.length);
    for (var questionData in questionList) {
      questions.add(QuizQuestion.fromJson(questionData));
    }
    // print(questions);
    return questions;
  }
}
