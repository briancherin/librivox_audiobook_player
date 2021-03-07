
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioSlider extends StatelessWidget {
  final void Function(double val) onChanged;
  final void Function(double val) onChangeStart;
  final void Function(double val) onChangeEnd;
  final double currPositionMillis;
  final double durationMillis;

  AudioSlider({this.onChanged, this.onChangeStart, this.onChangeEnd, this.currPositionMillis = 0, this.durationMillis = 0});

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: currPositionMillis,
        min: 0,
        max: durationMillis,
        onChanged: onChanged,
        onChangeStart: onChangeStart,
        onChangeEnd: onChangeEnd,
    );
  }

}