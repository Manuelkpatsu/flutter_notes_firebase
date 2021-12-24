import 'package:flutter/material.dart';
import 'package:notesapp/utils/note_priority.dart';

class PriorityPicker extends StatefulWidget {
  final Function(int)? onTap;
  int selectedIndex;

  PriorityPicker({
    Key? key,
    this.onTap,
    this.selectedIndex = 3,
  }) : super(key: key);

  @override
  _PriorityPickerState createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: NotePriority.priorityText.length,
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
              width: width / 3,
              height: 70,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.selectedIndex == index
                      ? NotePriority.priorityColor[index]
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                  border: widget.selectedIndex == index
                      ? Border.all(width: 2, color: Colors.black)
                      : Border.all(width: 0, color: Colors.transparent),
                ),
                child: Center(
                  child: Text(
                    NotePriority.priorityText[index],
                    style: TextStyle(
                      color: widget.selectedIndex == index ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
