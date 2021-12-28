import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/styles.dart';

class Helper {
  /// Shows a snackbar
  static void showSnackbar(
    BuildContext context,
    String text,
    Color backgroundColor,
  ) {
    final snackbar = SnackBar(
      content: Text(text, style: const TextStyle(color: Colors.white)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  /// Shows alert dialog
  static void showAlertDialog(
    BuildContext context,
    String title,
    VoidCallback onPressed,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel'.toUpperCase(),
                style: kNoteHeading5.copyWith(color: Colors.red.shade900),
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                'Ok'.toUpperCase(),
                style: kNoteHeading5.copyWith(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  static String formatDateTime(String dateTime) {
    var formatter = DateFormat('MMM dd, yyyy');
    var formatter2 = DateFormat('hh:mm a');
    DateTime dt = DateTime.parse(dateTime);
    if (dt.day == DateTime.now().day) {
      return formatter2.format(dt);
    } else {
      return formatter.format(dt);
    }
  }

  static String formatDateTimeAndDisplayWithTime(String dateTime) {
    var formatter = DateFormat('MMMM dd, yyyy hh:mm a');
    DateTime dt = DateTime.parse(dateTime);
    return formatter.format(dt);
  }

  static Timestamp formatStringDateToTimestamp(String date) {
    DateTime dt = DateTime.parse(date);
    return Timestamp.fromMillisecondsSinceEpoch(dt.millisecondsSinceEpoch);
  }
}
