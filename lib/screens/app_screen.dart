

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librivox_audiobook_player/resources/audiobook_repository.dart';
import 'package:librivox_audiobook_player/resources/blocs/navigation/navigation_bloc.dart';
import 'package:librivox_audiobook_player/resources/blocs/navigation/navigation_event.dart';
import 'package:librivox_audiobook_player/resources/blocs/navigation/navigation_state.dart';

import 'catalog/blocs/catalog_bloc.dart';
import 'catalog/blocs/catalog_event.dart';
import 'catalog/catalog.dart';


class NavIndex {
  // these values need to be consistent with the ordering in the items list of the bottomNavigationBar
  static const int NAV_INDEX_LIBRARY = 0;
  static const int NAV_INDEX_CATALOG = 1;
}



class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, NavigationState state) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        if (state is ShowLibrary) {
          return buildScreen(context, NavIndex.NAV_INDEX_LIBRARY, Text("Library"));
        }
        else if (state is ShowCatalog) {
          return buildScreen(context, NavIndex.NAV_INDEX_CATALOG,
              BlocProvider<CatalogBloc>(
                  create: (context) {
                    final AudiobookRepository audiobookRepository = RepositoryProvider.of<AudiobookRepository>(context);

                    // Determine the number of cards that can fit in the grid, according to the screen size.
                    // This is needed so that the Catalog can initialize with the correct number of initial items.
                    int initialGridSize = (screenWidth ~/ CatalogScreen.GRID_CARD_WIDTH) * ((screenHeight ~/ CatalogScreen.GRID_CARD_WIDTH) + 1);
                    return CatalogBloc(audiobookRepository)..add(CatalogOpened(maxInitialItems: initialGridSize));
                  },
                  child: CatalogScreen()
              ));
        }
        return buildScreen(context, NavIndex.NAV_INDEX_LIBRARY, Text("Library"));
      },
    );
    // return buildScreen(NavIndex.NAV_INDEX_LIBRARY);
  }


  Scaffold buildScreen(context, int pageIndex, Widget body) {
    NavigationBloc _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (index) {
            if (index == NavIndex.NAV_INDEX_LIBRARY) _navigationBloc.add(UserClickedLibrary());
            if (index == NavIndex.NAV_INDEX_CATALOG) _navigationBloc.add(UserClickedCatalog());
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.circle), label: "Library"),
            BottomNavigationBarItem(icon: Icon(Icons.crop_square), label: "Catalog"),
          ]
      ),
    );
  }

}

