
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/components/play_button.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_bloc.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_event.dart';

import 'blocs/audiobook_info_state.dart';

class AudiobookInfoScreen extends StatelessWidget {
  final Audiobook audiobook;

  const AudiobookInfoScreen({@required this.audiobook});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocBuilder<AudiobookInfoBloc, AudiobookInfoState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(height: 200, width: 200, decoration: BoxDecoration(color: Colors.grey),
                      child: audiobook.coverImageUrl != null ? Image.network(audiobook.coverImageUrl, fit: BoxFit.fill,) : SizedBox(height:0)
                    ),
                    SizedBox(height: 30),
                    Text(audiobook.title, style: TextStyle(fontSize: 30),),
                    Text("by " + audiobook.author, style: TextStyle(fontSize: 15)),
                    SizedBox(height: 10),
                    Text(audiobook.numChapters.toString() + " chapters"),
                    Text("Duration: " + getTimestampFromSeconds(audiobook.duration)),
                    SizedBox(height: 20),
                    PlayButton(
                      state: state.audiobookIsPlaying ? PlayButtonState.SHOW_PAUSE : PlayButtonState.SHOW_PLAY,
                      onTap: () {
                        BlocProvider.of<AudiobookInfoBloc>(context).add(
                          state.audiobookIsPlaying
                            ? UserClickedPause(audiobook: audiobook)
                            : UserClickedPlay(audiobook: audiobook)
                        );
                      }
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: 400,
                      child: Center(
                        child: Text(audiobook.description, textAlign: TextAlign.center,),
                      ),
                    ),
                  ],
                )
              )
            );
          }
        )
      ),
    );
  }

  String getTimestampFromSeconds(int totalSeconds) {

    int seconds = totalSeconds % 60;
    int minutes = ((totalSeconds - seconds) ~/ 60) % 60;
    int hours = (totalSeconds - seconds - (minutes * 60)) ~/ 3600;

    return "${padNumber(hours)}:${padNumber(minutes)}:${padNumber(seconds)}";
  }

  String padNumber(int num) {
    return num < 10 ? "0$num" : "$num";
  }

}