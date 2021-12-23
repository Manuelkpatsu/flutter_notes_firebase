import 'package:flutter/material.dart';
import 'package:notesapp/styles.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FormFieldValidator<String>? validator;
  final TextCapitalization textCapitalization;
  final String? hintText;

  const TextInputField({
    Key? key,
    required this.controller,
    this.inputType,
    this.inputAction,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: textWhiteGrey,
        hintText: hintText,
        hintStyle: kNoteHeading6.copyWith(color: textGrey),
      ),
      keyboardType: inputType,
      textInputAction: inputAction,
      validator: validator,
      textCapitalization: textCapitalization,
    );
  }
}
