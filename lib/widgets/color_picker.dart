import 'package:flutter/material.dart';
import 'package:notesapp/utils/note_colors.dart';

class ColorPicker extends StatefulWidget {
  final Function(int)? onTap;
  int selectedIndex;

  ColorPicker({
    Key? key,
    this.onTap,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: NoteColors.colors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: widget.onTap != null ? () {
              setState(() {
                widget.selectedIndex = index;
              });
              widget.onTap!(index);
            } : null,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 50,
              height: 50,
              child: Container(
                child: Center(
                    child: widget.selectedIndex == index
                        ? const Icon(Icons.done)
                        : Container()),
                decoration: BoxDecoration(
                  color: NoteColors.colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
