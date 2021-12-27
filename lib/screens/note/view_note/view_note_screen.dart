import 'package:flutter/material.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/screens/note/add_update_note/add_update_note_screen.dart';
import 'package:notesapp/screens/note/add_update_note/note_arguments.dart';
import 'package:notesapp/screens/note/view_note/view_note_argument.dart';
import 'package:notesapp/utils/helper.dart';
import 'package:notesapp/utils/note_colors.dart';
import 'package:notesapp/widgets/color_picker.dart';
import 'package:notesapp/widgets/custom_floating_action_button.dart';
import 'package:notesapp/widgets/priority_picker.dart';

import '../../../styles.dart';

class ViewNoteScreen extends StatefulWidget {
  final ViewNoteArgument argument;
  int color;

  static const routeName = '/note';

  ViewNoteScreen({
    Key? key,
    this.color = 2,
    required this.argument,
  }) : super(key: key);

  @override
  _ViewNoteScreenState createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: 'Learn a programming language');
    _descriptionController = TextEditingController(
        text: 'Learn a new programming language. React will be a best fit for me.');
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NoteColors.colors[widget.color],
      appBar: AppBar(
        backgroundColor: NoteColors.colors[widget.color],
        title: Text(
          _titleController.text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriorityPicker(
              selectedIndex: 0,
            ),
            ColorPicker(
              selectedIndex: widget.color,
            ),
            titleTextField(),
            const SizedBox(height: 5),
            date(),
            descriptionTextField(),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          NoteArguments noteArguments = NoteArguments(
            title: _titleController.text,
            description: _descriptionController.text,
            priority: 2,
            color: widget.color,
          );

          Navigator.of(context).pushNamed(
            AddUpdateNoteScreen.routeName,
            arguments: noteArguments,
          );
        },
        icon: Icons.edit_outlined,
        tooltip: S.current.editNote,
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: TextField(
        controller: _titleController,
        maxLines: null,
        style: Theme.of(context).textTheme.bodyText2,
        readOnly: true,
        decoration: InputDecoration.collapsed(
          hintText: S.current.title,
        ),
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
          Text(
            Helper.formatDateTimeAndDisplayWithTime('2021-12-23T04:59:07.389+00:00'),
            style: kNoteSubTitle,
          )
        ],
      ),
    );
  }

  Widget descriptionTextField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _descriptionController,
        maxLines: null,
        style: Theme.of(context).textTheme.bodyText1,
        readOnly: true,
        decoration: InputDecoration.collapsed(
          hintText: S.current.description,
        ),
      ),
    );
  }
}
