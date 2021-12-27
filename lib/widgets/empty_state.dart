import 'package:flutter/material.dart';

import '../styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/box.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            const Text(
              'Empty notes.\nClick on + button to add notes.',
              textAlign: TextAlign.center,
              style: kNoteBodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
