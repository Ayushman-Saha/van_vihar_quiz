import 'package:van_vihar_quiz/entities/leaderboardData.dart';
import 'package:van_vihar_quiz/repository/leaderboardRepository.dart';

class LeaderboardController {
  late LeaderboardRepository leaderboardRepository;
  LeaderboardController() {
    leaderboardRepository = LeaderboardRepository();
  }

  List<LeaderboardData> _leaderboard = [];

  List<LeaderboardData> getLeaderboard() {
    return _leaderboard;
  }

  Future<void> initializeLeaderboard() async {
    var leaderboard = await leaderboardRepository.getQuestions();
    _leaderboard = leaderboard;
  }
}
