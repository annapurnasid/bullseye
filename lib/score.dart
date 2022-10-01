import 'package:flutter/material.dart';

import 'about.dart';
import 'styled_button.dart';
import 'text_styles.dart';

// The score widget for displaying the current score and the round.

class Score extends StatelessWidget {
  const Score(
      {Key? key,
      required this.totalScore,
      required this.round,
      required this.onStartOver})
      : super(key: key);

  final int totalScore;
  final int round;

  // Callback method to start over the game
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StyledButton(
          icon: Icons.refresh,
          onPressed: () {
            onStartOver();
          },
        ), // Button to start over
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: Column(
              children: <Widget>[
                Text('Score:', style: LabelTextStyle.bodyText1(context)),
                Text('$totalScore',
                    style: ScoreNumberTextStyle.headline4(context)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            children: <Widget>[
              Text('Round:', style: LabelTextStyle.bodyText1(context)),
              Text('$round', style: ScoreNumberTextStyle.headline4(context)),
            ],
          ),
        ),
        StyledButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const AboutPage()));
          },
          icon: Icons.info,
        )
      ],
    );
  }
}
