import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String tooltip;
  final VoidCallback onPressed;
  final IconData icon;

  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.tooltip,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      shape: const CircleBorder(side: BorderSide(color: Colors.black, width: 2.0)),
      child: Icon(icon, color: Colors.black),
      backgroundColor: Colors.white,
    );
  }
}
