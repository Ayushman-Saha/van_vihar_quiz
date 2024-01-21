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
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 0.65 * MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "#$rank",
                        style: headingTextStyle.copyWith(color: textGreen),
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(displayPicture),
                        radius: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          name,
                          style: buttonTextStyle.copyWith(color: textGreen),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      score.toString(),
                      style: headingTextStyle.copyWith(color: textGreen),
                    ),
                    Text(
                      returnFormattedTime(timeTaken),
                      style: bodyTextStyle.copyWith(color: textGreen),
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
