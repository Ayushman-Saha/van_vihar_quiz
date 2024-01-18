import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/credentials.dart';
import 'package:van_vihar_quiz/entities/quizDetailsData.dart';

import '../entities/quizQuestion.dart';

class QuizRepository {
  Future<QuizDetailsData> getQuizDetails() async {
    var response = await http.get(Uri.parse("$BASE_URL/quizDetails/get"));
    var quizDetails = jsonDecode(response.body);

    return QuizDetailsData.fromJson(quizDetails["data"]);
  }

  Future<Map<String, List<QuizQuestion>>> getQuestions(
      int questionCount, List<dynamic> tags) async {
    var response = (tags.isEmpty)
        ? await http.get(Uri.parse(
            "$BASE_URL/quizQuestion/get?questionCount=$questionCount"))
        : await http.get(Uri.parse(
            "$BASE_URL/quizQuestion/get?questionCount=$questionCount&tags=${tags.toString().substring(1, tags.length)}"));

    Map<String, List<QuizQuestion>> questions = {};
    var decodedResponse = jsonDecode(response.body);

    var easyQuestions =
        _responseToQuizQuestions(decodedResponse["data"][0]["easyQuestions"]);
    questions.addEntries({"easy": easyQuestions}.entries);

    var mediumQuestions =
        _responseToQuizQuestions(decodedResponse["data"][0]["mediumQuestions"]);
    questions.addEntries({"medium": mediumQuestions}.entries);

    var hardQuestions =
        _responseToQuizQuestions(decodedResponse["data"][0]["hardQuestions"]);
    questions.addEntries({"hard": hardQuestions}.entries);

    return questions;
  }

  List<QuizQuestion> _responseToQuizQuestions(List questionList) {
    List<QuizQuestion> questions = [];
    for (var questionData in questionList) {
      questions.add(QuizQuestion.fromJson(questionData));
    }
    // print(questions);
    return questions;
  }
}
