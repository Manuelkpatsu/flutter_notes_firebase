import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notesapp/widgets/empty_state.dart';
import 'package:notesapp/generated/l10n.dart';

import '../../../locator.dart';
import 'search_bloc.dart';
import 'search_event.dart';
import 'search_note_tile.dart';
import 'search_note_tile_model_data.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchBloc bloc;
  final eventController = StreamController<SearchEvent>();
  final searchTextEditingController = TextEditingController();

  @override
  void initState() {
    bloc = get<SearchBloc>(param1: context, param2: eventController);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey.shade200,
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                searchIcon(),
                const SizedBox(width: 10),
                searchTextField(),
                const SizedBox(width: 5),
                clearSearchQueryButton(),
              ],
            ),
          ),
          Expanded(
            child: noteList(),
          ),
        ],
      ),
    );
  }

  Widget searchIcon() {
    return const Icon(
      Icons.search,
      size: 25,
      color: Colors.black54,
    );
  }

  Widget searchTextField() {
    return Expanded(
      child: TextFormField(
        controller: searchTextEditingController,
        autofocus: false,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: S.current.searchNoteByTitle,
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
        ),
        onChanged: (searchQuery) {
          eventController.add(SearchNoteEvent(searchQuery));
        },
      ),
    );
  }

  Widget clearSearchQueryButton() {
    return IconButton(
      icon: const Icon(
        Icons.cancel,
        size: 20,
        color: Colors.black54,
      ),
      onPressed: () {
        if (searchTextEditingController.text.isNotEmpty) {
          searchTextEditingController.clear();
          eventController.add(ClearSearchQueryEvent());
        }
      },
      splashRadius: 20,
    );
  }

  Widget noteList() {
    return ValueListenableBuilder<List<SearchNoteTileModelData>>(
      valueListenable: bloc,
      builder: (context, modelDataList, child) {
        if (modelDataList.isEmpty) {
          return EmptyState(info: S.current.noNotesForSearchQuery);
        } else {
          return StaggeredGridView.countBuilder(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 4,
            itemCount: modelDataList.length,
            itemBuilder: (BuildContext context, int index) {
              return SearchNoteTile(context, modelDataList[index]);
            },
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(4),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
        }
      },
    );
  }
}
