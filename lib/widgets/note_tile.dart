import 'package:flutter/material.dart';
import 'package:notesapp/utils/helper.dart';

class NoteTile extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String? priority;
  final String description;
  final String date;
  final Color color;
  final Color? priorityColor;

  const NoteTile({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.description,
    required this.color,
    this.priority,
    this.priorityColor,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
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
                        title,
                        style: Theme.of(context).textTheme.bodyText2,
                      )),
                  const SizedBox(width: 10),
                  Text(
                    priority!,
                    style: TextStyle(color: priorityColor),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  Helper.formatDateTime(date),
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
