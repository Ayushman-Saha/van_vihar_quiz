class LeaderboardData {
  final String name;
  final String displayPicture;
  final int score;
  final int timeTaken;
  final String uid;

  LeaderboardData(
      {required this.name,
      required this.displayPicture,
      required this.score,
      required this.timeTaken,
      required this.uid});

  factory LeaderboardData.fromJson(dynamic json) {
    return LeaderboardData(
      name: json["name"],
      displayPicture: json["displayPicture"],
      score: json["score"],
      timeTaken: json["timeTaken"],
      uid: json["uid"],
    );
  }
}
