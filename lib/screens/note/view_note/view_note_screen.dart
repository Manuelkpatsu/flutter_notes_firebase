import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/model/note.dart';
import 'package:notesapp/screens/note/add_update_note/note_arguments.dart';
import 'package:notesapp/screens/note/view_note/view_note_argument.dart';
import 'package:notesapp/screens/note/view_note/view_note_model_data.dart';
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
    return ValueListenableBuilder<ViewNoteModelData>(
      valueListenable: bloc,
      builder: (context, modelData, child) {
        return Scaffold(
          backgroundColor: NoteColors.colors[modelData.color],
          appBar: AppBar(
            backgroundColor: NoteColors.colors[modelData.color],
            title: Text(
              modelData.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5,
            ),
            actions: [deleteNote()],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PriorityPicker(
                  selectedIndex: 3 - modelData.priority,
                ),
                ColorPicker(
                  selectedIndex: modelData.color,
                ),
                titleText(modelData.title),
                const SizedBox(height: 5),
                date(modelData.date),
                descriptionText(modelData.description),
              ],
            ),
          ),
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () {
              Note note = Note(
                  id: modelData.noteId,
                  title: modelData.title,
                  userId: modelData.userId,
                  description: modelData.description,
                  color: modelData.color,
                  priority: modelData.priority,
                  createdAt: Helper.formatStringDateToTimestamp(modelData.date)
              );
              eventController.add(EditNoteEvent(NoteArguments(note: note)));
            },
            icon: Icons.edit_outlined,
            tooltip: S.current.editNote,
          ),
        );
      },
    );
  }

  Widget titleText(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  Widget date(String date) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.access_time_rounded),
          const SizedBox(width: 5),
          Text(
            Helper.formatDateTimeAndDisplayWithTime(date),
            style: kNoteSubTitle,
          ),
        ],
      ),
    );
  }

  Widget descriptionText(String description) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodyText1,
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
