
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

class AudiobookInfoScreen extends StatelessWidget {
  final Audiobook audiobook;

  const AudiobookInfoScreen({@required this.audiobook});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Librivox Audiobook Player",
      home: Center(
        child: Text(audiobook.title)
      )
    );
  }

}