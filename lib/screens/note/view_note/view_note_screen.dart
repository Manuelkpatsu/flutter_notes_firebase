import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/screens/note/view_note/view_note_argument.dart';
import 'package:notesapp/utils/helper.dart';
import 'package:notesapp/utils/note_colors.dart';
import 'package:notesapp/widgets/color_picker.dart';
import 'package:notesapp/widgets/custom_floating_action_button.dart';
import 'package:notesapp/widgets/priority_picker.dart';
import 'package:tuple/tuple.dart';

import '../../../locator.dart';
import '../../../styles.dart';
import 'view_note_bloc.dart';
import 'view_note_event.dart';
import 'view_note_listenable.dart';

class ViewNoteScreen extends StatefulWidget {
  final ViewNoteArgument argument;

  static const routeName = '/note';

  ViewNoteScreen({
    Key? key,
    required this.argument,
  }) : super(key: key);

  @override
  _ViewNoteScreenState createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  late final ViewNoteBloc bloc;
  final eventController = StreamController<ViewNoteEvent>();

  @override
  void initState() {
    bloc = get<ViewNoteBloc>(
      param1: context,
      param2: Tuple2(eventController, widget.argument.noteId),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: bloc.color,
      builder: (context, color, child) {
        return Scaffold(
          backgroundColor: NoteColors.colors[color],
          appBar: AppBar(
            backgroundColor: NoteColors.colors[color],
            title: ValueListenableBuilder<String>(
              valueListenable: bloc.title,
              builder: (context, title, child) {
                return Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                );
              },
            ),
            actions: [deleteNote()],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: bloc.priority,
                  builder: (context, priority, child) {
                    return PriorityPicker(
                      selectedIndex: priority,
                    );
                  },
                ),
                ColorPicker(
                  selectedIndex: color,
                ),
                titleText(),
                const SizedBox(height: 5),
                date(),
                descriptionText(),
              ],
            ),
          ),
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () {
              eventController.add(EditNoteEvent());
            },
            icon: Icons.edit_outlined,
            tooltip: S.current.editNote,
          ),
        );
      },
    );
  }

  Widget titleText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: ValueListenableBuilder<String>(
        valueListenable: bloc.title,
        builder: (context, title, child) {
          return Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          );
        },
      ),
    );
  }

  Widget date() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.access_time_rounded),
          const SizedBox(width: 5),
          ValueListenableBuilder<String>(
              valueListenable: bloc.date,
              builder: (context, date, child) {
                return Text(
                  Helper.formatDateTimeAndDisplayWithTime(date),
                  style: kNoteSubTitle,
                );
              }),
        ],
      ),
    );
  }

  Widget descriptionText() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder<String>(
        valueListenable: bloc.description,
        builder: (context, description, child) {
          return Text(
            description,
            style: Theme.of(context).textTheme.bodyText1,
          );
        },
      ),
    );
  }

  Widget deleteNote() {
    return IconButton(
      icon: const Icon(Icons.delete_outlined),
      onPressed: () {
        eventController.add(DeleteNoteEvent());
      },
    );
  }
}
