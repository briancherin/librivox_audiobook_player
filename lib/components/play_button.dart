
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librivox_audiobook_player/components/generic_icon_button.dart';

enum PlayButtonState {
  PLAYING,
  PAUSED
}

class PlayButton extends StatelessWidget {
  final PlayButtonState state;
  final Function onTap;

  PlayButton({@required this.state, this.onTap});


  @override
  Widget build(BuildContext context) {
    return GenericIconButton(
      height: 80,
      width: 80,
      icon: Icon(state == PlayButtonState.PLAYING ? Icons.pause : Icons.play_arrow, size: 50),
      onTap: onTap
    );

  }

}