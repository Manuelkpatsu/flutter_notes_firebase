import 'package:flutter/material.dart';

import '../styles.dart';

class ErrorState extends StatelessWidget {
  final String text;

  const ErrorState({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          text,
          style: kNoteBodyText1,
        ),
      ),
    );
  }
}
