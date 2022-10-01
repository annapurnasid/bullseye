import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game_model.dart';
import 'slide_thumb_image.dart';

// Control widget to create the min & max text label and slider

class Control extends StatefulWidget {
  const Control({Key? key, required this.model}) : super(key: key);

  final GameModel model;

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  ui.Image? _sliderImage;

  // load asset from the image
  Future<ui.Image> _load(String asset) async {
    final data = await rootBundle.load(asset);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  // Called each time the image is reset
  void initState() {
    // loading the image here
    _load('images/nub.png').then((image) {
      setState(() {
        _sliderImage = image;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 90.0),
          child: Text(
            '1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.red[700],
                inactiveTrackColor: Colors.red[700],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 8.0,
                thumbColor: Colors.redAccent,
                thumbShape: SliderThumbImage(_sliderImage),
                overlayColor: Colors.red.withAlpha(32),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 25.0)),
            child: Slider(
              value: widget.model.current.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  widget.model.current = newValue.toInt();
                });
              },
              min: 1.0,
              max: 100.0,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 90.0),
          child: Text('100', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
