import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.13 * MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          // border: Border.all(color: textWhite),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Card(
        elevation: 10,
        color: backgroundGreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: textWhite,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/ic_logo_van_vihar.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 0.45 * MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Van Vihar National Park",
                    style: buttonTextStyle.copyWith(
                      color: textWhite,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: textWhite,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/ic_logo_iiserb.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
