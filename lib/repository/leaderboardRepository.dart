import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/credentials.dart';
import 'package:van_vihar_quiz/entities/leaderboardData.dart';

class LeaderboardRepository {
  Future<List<LeaderboardData>> getQuestions() async {
    var response =
        await http.get(Uri.parse("${BASE_URL}/quizResult/getLeaderboard"));
    return _responseToLeaderboardData(response);
  }

  List<LeaderboardData> _responseToLeaderboardData(dynamic response) {
    List<LeaderboardData> leaderboard = [];

    var list = jsonDecode(response.body);
    var leaderboardList = list["data"];
    // print(leaderboardList[0]);
    for (var leaderboardData in leaderboardList) {
      leaderboard.add(LeaderboardData.fromJson(leaderboardData));
    }

    return leaderboard;
  }
}
