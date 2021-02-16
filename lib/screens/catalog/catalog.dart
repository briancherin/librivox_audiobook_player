

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/audiobook_info.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_bloc.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_event.dart';

import 'blocs/catalog_state.dart';

class CatalogScreen extends StatelessWidget {


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
            if (state is AudiobookClicked) {
              // TODO: launch audiobook info screen
              Audiobook bookToOpen = state.audiobook;
            }
          },
          child: BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              final catalogBloc = BlocProvider.of<CatalogBloc>(context);

              if (state is CatalogLoading || state is CatalogInitial) {
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 2)
                );
              }
              if (state is CatalogLoaded) {
                return Center(
                  child: Column(
                    children: state.audiobooks.map((audiobook) {
                      return ElevatedButton(
                        child: Text(audiobook.title),
                        onPressed: () {
                          //catalogBloc.add(UserClickedAudiobook(audiobook: audiobook));
                          _openAudiobookInfoScreen(context, audiobook);
                        },
                      );
                    }).toList()
                  )
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
      MaterialPageRoute(builder: (context) => AudiobookInfoScreen(audiobook: audiobook))
    );
  }

}