import 'package:flutter/material.dart';

import '../styles.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FormFieldValidator<String>? validator;
  final TextCapitalization textCapitalization;
  final bool? obscureText;
  final VoidCallback? toggle;
  final String? hintText;

  const PasswordInputField({
    Key? key,
    required this.controller,
    this.inputType,
    this.inputAction,
    this.validator,
    this.obscureText,
    this.toggle,
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
          suffixIcon: IconButton(
            icon: obscureText!
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onPressed: toggle,
          )),
      keyboardType: inputType,
      textInputAction: inputAction,
      obscureText: obscureText!,
      validator: validator,
      textCapitalization: textCapitalization,
    );
  }
}
