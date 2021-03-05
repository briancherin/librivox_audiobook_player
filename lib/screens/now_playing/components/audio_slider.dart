
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Slider(
        value: 50,
        min: 0,
        max: 100,
        onChanged: (val){}
    );
  }

}