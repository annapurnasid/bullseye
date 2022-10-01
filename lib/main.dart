import 'dart:math';

import 'package:bullseye/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'control.dart';
import 'game_model.dart';
import 'hit_me_button.dart';
import 'prompt.dart';
import 'styled_button.dart';

void main() {
  runApp(const BullsEyeApp());
}

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return const MaterialApp(title: 'BullsEye', home: GamePage());
  }
}

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;
  bool _alertIsVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 32.0),
                child: Prompt(targetValue: _model.target),
              ),
              Control(model: _model),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: HitMeButton(
                    text: 'HIT ME',
                    onPressed: () {
                      _showAlert(context);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Score(
                    totalScore: _model.totalScore,
                    round: _model.round,
                    onStartOver: _startNewGame),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Function to calculate the current score
  // Done by finding diff between Target value and the slider's current value
  int _pointsForCurrentRound() {
    var bonus = 0;
    const int maxScore = 100;
    int difference = _differenceAmount();

    // Giving the player advantage of being closest to the target
    if (difference == 0) {
      bonus = 100;
    } else if (difference == 1) {
      bonus = 50;
    }
    return maxScore - difference + bonus;
  }

  // A context represents current widget
  // Used to access parent widgets or
  // find out about screen location information
  void _showAlert(BuildContext context) {
    var okButton = StyledButton(
        onPressed: () {
          // Dismiss the alert
          Navigator.of(context).pop();
          setState(() {
            _model.totalScore += _pointsForCurrentRound();
            _model.target = _newTargetValue();
            _model.round += 1;
          });
          _alertIsVisible = false;
        },
        icon: Icons.close);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_alertTitle()),
            content: Text('Slider Value: ${_model.current}. '
                'You scored ${_pointsForCurrentRound()} in this round.'),
            actions: [okButton],
            elevation: 5,
          );
        });
  }

  // Update the alert text depending on the current score
  String _alertTitle() {
    var difference = _differenceAmount();
    String title;
    if (difference == 0) {
      title = 'Perfect!';
    } else if (difference < 5) {
      title = 'You almost had it';
    } else if (difference <= 10) {
      title = 'Well tried';
    } else {
      title = 'Did you even try?';
    }
    return title;
  }

  int _differenceAmount() => (_model.target - _model.current).abs();

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    setState(() {
      _model.current = GameModel.sliderStart;
      _model.totalScore = GameModel.scoreStart;
      _model.round = GameModel.roundStart;
      _model.target = _newTargetValue();
    });
  }
}
