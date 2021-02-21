

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
        if (state is ShowLibrary) {
          return buildScreen(context, NavIndex.NAV_INDEX_LIBRARY, Text("Library"));
        }
        else if (state is ShowCatalog) {
          return buildScreen(context, NavIndex.NAV_INDEX_CATALOG,
              BlocProvider<CatalogBloc>(
                  create: (context) {
                    final AudiobookRepository audiobookRepository = AudiobookRepository();
                    return CatalogBloc(audiobookRepository)..add(CatalogOpened());
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
      appBar: AppBar(),
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

