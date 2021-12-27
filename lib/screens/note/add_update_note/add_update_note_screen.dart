import 'package:flutter/material.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/screens/note/home/home_screen.dart';
import 'package:notesapp/utils/helper.dart';
import 'package:notesapp/utils/note_colors.dart';
import 'package:notesapp/widgets/color_picker.dart';
import 'package:notesapp/widgets/priority_picker.dart';

import 'note_arguments.dart';

class AddUpdateNoteScreen extends StatefulWidget {
  static const routeName = '/add_update';

  final NoteArguments? noteArguments;

  const AddUpdateNoteScreen({
    Key? key,
    this.noteArguments,
  }) : super(key: key);

  @override
  _AddUpdateNoteScreenState createState() => _AddUpdateNoteScreenState();
}

class _AddUpdateNoteScreenState extends State<AddUpdateNoteScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  int _color = 0;
  late int _priority = 3;
  bool _edit = false;

  @override
  void initState() {
    super.initState();
    if (widget.noteArguments != null) {
      setState(() {
        _titleController = TextEditingController(text: widget.noteArguments!.title);
        _descriptionController =
            TextEditingController(text: widget.noteArguments!.description);
        _color = widget.noteArguments!.color;
        _priority = widget.noteArguments!.priority;
        _edit = true;
      });
    } else {
      setState(() {
        _titleController = TextEditingController(text: '');
        _descriptionController = TextEditingController(text: '');
      });
    }
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
      backgroundColor: NoteColors.colors[_color],
      appBar: AppBar(
        backgroundColor: NoteColors.colors[_color],
        title: Text(
          _edit ? S.current.editNote : S.current.addNote,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        actions: [saveNote()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriorityPicker(
              selectedIndex: 3 - _priority,
              onTap: (index) {
                setState(() {
                  _priority = 3 - index;
                });
              },
            ),
            ColorPicker(
              selectedIndex: _color,
              onTap: (index) {
                setState(() {
                  _color = index;
                });
              },
            ),
            titleTextField(),
            descriptionTextField(),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: TextField(
        controller: _titleController,
        maxLines: null,
        maxLength: 255,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration.collapsed(
          hintText: S.current.title,
        ),
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
        decoration: InputDecoration.collapsed(
          hintText: S.current.description,
        ),
      ),
    );
  }

  Widget saveNote() {
    return IconButton(
      icon: const Icon(Icons.save_outlined),
      onPressed: () {
        if (_descriptionController.text.isNotEmpty && _titleController.text.isNotEmpty) {
          Helper.showSnackbar(
            context,
            S.current.noteSaved,
            Colors.green,
          );
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        } else {
          Helper.showSnackbar(
            context,
            S.current.fieldsCannotBeEmpty,
            Colors.red.shade900,
          );
        }
      },
    );
  }
}
