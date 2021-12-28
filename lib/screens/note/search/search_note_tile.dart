import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/utils/helper.dart';
import 'package:notesapp/utils/note_colors.dart';
import 'package:notesapp/utils/note_priority.dart';

import '../../../locator.dart';
import 'search_note_tile_bloc.dart';
import 'search_note_tile_event.dart';
import 'search_note_tile_model_data.dart';

class SearchNoteTile extends StatelessWidget {
  late SearchNoteTileBloc bloc;
  final eventController = StreamController<SearchNoteTileEvent>();
  final SearchNoteTileModelData _modelData;

  SearchNoteTile(BuildContext context, this._modelData, {Key? key})
      : super(key: ValueKey(_modelData.id)) {
    bloc = get<SearchNoteTileBloc>(param1: context, param2: eventController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          eventController.add(GoToViewNoteScreenEvent(_modelData.id));
        },
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: NoteColors.colors[_modelData.color],
            border: Border.all(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _modelData.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    NotePriority.getPriorityText(_modelData.priority),
                    style: TextStyle(
                        color: NotePriority.getPriorityColor(_modelData.priority)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _modelData.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  Helper.formatDateTime(_modelData.date),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
