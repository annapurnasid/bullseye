import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Bulls Eye'),
        backgroundColor: Colors.red[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bulls Eye',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              ),
            ),
            const Text(
              'Play this game to win points by dragging the slider',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            const Text(
              'Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            const Text(
              'Enjoy!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                // Button to go back to the previous screen
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
