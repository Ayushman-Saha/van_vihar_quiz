import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';

class LeaderboardTile extends StatelessWidget {
  const LeaderboardTile({
    super.key,
    required this.displayPicture,
    required this.name,
    required this.score,
    required this.timeTaken,
    required this.rank,
  });

  final int rank;
  final String displayPicture;
  final String name;
  final int score;
  final int timeTaken;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 100,
        child: Card(
          color: headerBlue,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "#$rank",
                  style: headingTextStyle,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(displayPicture),
                  radius: 30,
                ),
                Text(
                  name,
                  style: buttonTextStyle,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      score.toString(),
                      style: headingTextStyle,
                    ),
                    Text(
                      returnFormattedTime(timeTaken),
                      style: bodyTextStyle,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
