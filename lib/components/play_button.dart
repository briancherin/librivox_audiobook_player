
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PlayButtonState {
  SHOW_PAUSE,
  SHOW_PLAY
}

class PlayButton extends StatelessWidget {
  final PlayButtonState state;
  final Function onTap;

  PlayButton({@required this.state, this.onTap});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Material(
          color: Colors.black12,
          child:InkWell(
            child: Icon(state == PlayButtonState.SHOW_PAUSE ? Icons.pause : Icons.play_arrow, size: 50),
            onTap: onTap,
          )),
    );
  }

}