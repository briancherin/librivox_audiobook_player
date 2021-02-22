

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/audiobook_info.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_bloc.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_event.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_bloc.dart';

import 'blocs/catalog_state.dart';


class CatalogScreen extends StatelessWidget {

  static const GRID_CARD_WIDTH = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Catalog")
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocListener<CatalogBloc, CatalogState>(
          listener: (context, state) {

          },
          child: BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoading || state is CatalogInitial) {
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 2)
                );
              }
              if (state is CatalogLoaded) {
                return Center(
                  child: _audiobookGrid(state.audiobooks, context)

                );
              }
              return Center(
                  child: CircularProgressIndicator(strokeWidth: 2)
              );
            }
          )
      )
      )
    );
  }

  _openAudiobookInfoScreen(context, Audiobook audiobook) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {

        return BlocProvider<AudiobookInfoBloc>(
          create: (context) {
            return AudiobookInfoBloc()..add(AudiobookInfoOpened(audiobook: audiobook));
          },
          child: AudiobookInfoScreen(audiobook: audiobook)
        );
        // return AudiobookInfoScreen(audiobook: audiobook);
      })
    );
  }

  _audiobookGrid(List<Audiobook> audiobooks, context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int numColumns = screenWidth ~/ GRID_CARD_WIDTH;
    return GridView.count(
      crossAxisCount: numColumns,
      children: audiobooks.map((audiobook) {
        return InkWell(
          onTap: () {
            _openAudiobookInfoScreen(context, audiobook);
          },
          child: Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Colors.grey), // TODO: put cover image here
            child: //Column(
              //children: [
                audiobook.coverImageUrl != null ? Image.network(audiobook.coverImageUrl, fit: BoxFit.fill) : SizedBox(height: 0),
                //Text(audiobook.title)
              //]
            //),
          )
        );
      }).toList()
    );
  }

}