import 'package:flutter/material.dart';

import '../styles.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.buttonColor,
    required this.text,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: kNoteHeading5.copyWith(color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          primary: buttonColor,
          onPrimary: textColor,
          elevation: 0,
        ),
      ),
    );
  }
}
