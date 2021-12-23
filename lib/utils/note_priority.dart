import 'package:flutter/material.dart';

class NotePriority {
  const NotePriority._();

  static List<String> priorityText = [
    'Low',
    'High',
    'Very High',
  ];

  static List<Color> priorityColor = [
    Colors.green,
    Colors.lightGreen,
    Colors.red,
  ];

  // Returns the priority color
  static Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.green;
      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  static String getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return '!!!';
      case 2:
        return '!!';
      case 3:
        return '!';
      default:
        return '!';
    }
  }
}
