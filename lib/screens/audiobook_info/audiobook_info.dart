
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';

class AudiobookInfoScreen extends StatelessWidget {
  final Audiobook audiobook;

  const AudiobookInfoScreen({@required this.audiobook});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Container(height: 300, width: 300, decoration: BoxDecoration(color: Colors.grey),),
              SizedBox(height: 30),
              Text(audiobook.title, style: TextStyle(fontSize: 30),),
              Text("by " + audiobook.author),
              SizedBox(height: 10),
              Text(audiobook.numChapters.toString() + " chapters"),
              Text("Duration: " + getTimestampFromSeconds(audiobook.duration)),
            ],
          )
        )
      ),
    );
  }

  String getTimestampFromSeconds(int totalSeconds) {

    int seconds = totalSeconds % 60;
    int minutes = (((totalSeconds - seconds) / 60) as int) % 60;
    int hours = (totalSeconds - seconds - (minutes * 60)) / 3600 as int;

    return "${padNumber(hours)}:${padNumber(minutes)}:${padNumber(seconds)}";
  }

  String padNumber(int num) {
    return num < 10 ? "0$num" : "$num";
  }

}