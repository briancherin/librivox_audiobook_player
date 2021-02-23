

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

// Infinite scrolling with guidance from https://medium.com/flutter-community/flutter-infinite-list-tutorial-with-flutter-bloc-2fc7a272ec67

class CatalogScreen extends StatefulWidget {
  static const GRID_CARD_WIDTH = 150;

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {

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
              if (!state.initialItemsLoaded) {
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 2)
                );
              }
              else {
                return Center(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child:  Column(
                      children: [
                        _audiobookGrid(state.audiobooks, context),
                        SizedBox(height: 5),
                        // Spinner shows if the user scrolls to the bottom of the grid, and more items are loading
                        state.currState is CatalogLoading ? CircularProgressIndicator(strokeWidth: 2) : SizedBox(height: 0),
                        SizedBox(height: 5),
                      ]
                    )
                  )
                );
              }
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
      })
    );
  }

  _audiobookGrid(List<Audiobook> audiobooks, context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int numColumns = screenWidth ~/ CatalogScreen.GRID_CARD_WIDTH;
    return GridView.builder(
        // The GridView will be wrapped in a SingleChildScrollView to allow it to scroll.
        // This is needed so that the spinner (when more items are loading) can be shown
        // below the GridView (in a Column)
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),

        itemCount: audiobooks.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numColumns
        ),
        itemBuilder: (context, int index) {
          return _audiobookCard(context, audiobooks[index]);
        },
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