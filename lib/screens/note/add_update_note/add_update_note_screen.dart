import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/model/note.dart';
import 'package:notesapp/utils/note_colors.dart';
import 'package:notesapp/widgets/color_picker.dart';
import 'package:notesapp/widgets/priority_picker.dart';

import '../../../locator.dart';
import 'add_update_note_bloc.dart';
import 'add_update_note_event.dart';
import 'add_update_note_listenable.dart';
import 'note_arguments.dart';

class AddUpdateNoteScreen extends StatefulWidget {
  static const routeName = '/add_update';

  final NoteArguments noteArguments;

  const AddUpdateNoteScreen({
    Key? key,
    required this.noteArguments,
  }) : super(key: key);

  @override
  _AddUpdateNoteScreenState createState() => _AddUpdateNoteScreenState();
}

class _AddUpdateNoteScreenState extends State<AddUpdateNoteScreen> {
  late final AddUpdateNoteBloc bloc;
  final eventController = StreamController<AddUpdateNoteEvent>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  int _color = 0;
  int _priority = 3;
  bool _edit = false;
  String _userId = '';

  @override
  void initState() {
    super.initState();
    bloc = get<AddUpdateNoteBloc>(param1: context, param2: eventController);
    if (widget.noteArguments.note != null) {
      _titleController = TextEditingController(text: widget.noteArguments.note!.title);
      _descriptionController =
          TextEditingController(text: widget.noteArguments.note!.description);
      _color = widget.noteArguments.note!.color;
      _priority = widget.noteArguments.note!.priority;
      _edit = true;
    } else {
      _titleController = TextEditingController(text: '');
      _descriptionController = TextEditingController(text: '');
      _userId = widget.noteArguments.userId!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NoteColors.colors[_color],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(
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
            progressIndicator(),
          ],
        ),
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

  Widget progressIndicator() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ValueListenableBuilder<bool>(
          valueListenable: bloc.progressIndicator,
          child: const LinearProgressIndicator(
            minHeight: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          builder: (context, show, child) {
            return Visibility(
              visible: show,
              child: child!,
            );
          },
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: TextField(
        controller: _titleController,
        textCapitalization: TextCapitalization.sentences,
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
        textCapitalization: TextCapitalization.sentences,
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
        if (_edit) {
          Note updatedNote = Note(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            color: _color,
            priority: _priority,
            userId: widget.noteArguments.note!.userId,
            createdAt: widget.noteArguments.note!.createdAt,
          );

          eventController
              .add(UpdateNoteEvent(widget.noteArguments.note!.id, updatedNote));
        } else {
          Note newNote = Note(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            color: _color,
            priority: _priority,
            userId: _userId,
          );

          eventController.add(CreateNoteEvent(newNote));
        }
      },
    );
  }
}
