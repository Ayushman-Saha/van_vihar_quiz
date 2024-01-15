class LeaderboardData {
  final String name;
  final String displayPicture;
  final int score;
  final int timeTaken;

  LeaderboardData({
    required this.name,
    required this.displayPicture,
    required this.score,
    required this.timeTaken,
  });

  factory LeaderboardData.fromJson(dynamic json) {
    return LeaderboardData(
      name: json["name"],
      displayPicture: json["displayPicture"],
      score: json["score"],
      timeTaken: json["timeTaken"],
    );
  }
}
