

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/resources/models/audiobook.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/audiobook_info.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_bloc.dart';
import 'package:librivox_audiobook_player/screens/audiobook_info/blocs/audiobook_info_event.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_bloc.dart';
import 'package:librivox_audiobook_player/screens/catalog/blocs/catalog_event.dart';

import 'blocs/catalog_state.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {

  static const _GRID_CARD_WIDTH = 200;
  static const _SCROLL_THRESHOLD = 200.0;

  final _scrollController = ScrollController();

  _CatalogScreenState() {
    _scrollController.addListener(_onScroll);
  }

  _onScroll() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currScroll = _scrollController.position.pixels;

    if (maxScroll - currScroll <= _SCROLL_THRESHOLD) {
      BlocProvider.of<CatalogBloc>(context).add(LoadMoreResults());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Catalog")
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child:  BlocBuilder<CatalogBloc, CatalogState>(
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
    int numColumns = screenWidth ~/ _GRID_CARD_WIDTH;
    return GridView.builder(
        itemCount: audiobooks.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numColumns
        ),
        itemBuilder: (context, int index) {
          return _audiobookCard(context, audiobooks[index]);
        },
        controller: _scrollController,
    );
  }
  
  _audiobookCard(context, Audiobook audiobook) {
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
  }

}