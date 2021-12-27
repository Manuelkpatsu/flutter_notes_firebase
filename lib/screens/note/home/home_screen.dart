import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notesapp/screens/note/home/home_model_data.dart';
import 'package:notesapp/screens/note/home/home_tile.dart';
import 'package:notesapp/styles.dart';
import 'package:notesapp/widgets/custom_floating_action_button.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/widgets/empty_state.dart';
import 'package:notesapp/widgets/error_state.dart';

import '../../../locator.dart';
import 'home_bloc.dart';
import 'home_event.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc bloc;
  final eventController = StreamController<HomeEvent>();

  @override
  void initState() {
    bloc = get<HomeBloc>(param1: context, param2: eventController);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: notesList(),
      floatingActionButton: addNoteButton(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        S.current.appTitle,
        style: Theme.of(context).textTheme.headline5,
      ),
      centerTitle: true,
      leading: IconButton(
        splashRadius: 30,
        icon: const Icon(Icons.search),
        onPressed: () {
          eventController.add(GoToSearchScreenEvent());
        },
      ),
      actions: [
        menuButton(),
      ],
    );
  }

  Widget menuButton() {
    return SizedBox(
      width: 50,
      child: PopupMenuButton<String>(
        icon: ClipOval(
          child: Align(
            heightFactor: 1,
            widthFactor: 1,
            child: Image.asset('assets/images/profile.png'),
          ),
        ),
        onSelected: (itemSelected) {
          switch (itemSelected) {
            case '1':
              logout();
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: '1',
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text(
                S.current.logOut,
                style: kNoteBodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notesList() {
    return ValueListenableBuilder<HomeModelData>(
      valueListenable: bloc,
      builder: (context, modelData, child) {
        if (modelData.message.isNotEmpty) {
          return ErrorState(text: modelData.message);
        } else if (modelData.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (modelData.notes.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return StaggeredGridView.countBuilder(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 4,
            itemCount: modelData.notes.length,
            itemBuilder: (BuildContext context, int index) {
              return HomeTile(context, modelData.notes[index]);
            },
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
        }
      },
    );
  }

  Widget addNoteButton() {
    return CustomFloatingActionButton(
      onPressed: () {
        eventController.add(GoToAddNoteScreenEvent());
      },
      tooltip: S.current.addNote,
      icon: Icons.add,
    );
  }

  void logout() {
    eventController.add(LogoutEvent());
  }
}
