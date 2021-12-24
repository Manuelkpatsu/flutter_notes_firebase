import 'package:flutter/material.dart';
import 'package:notesapp/screens/auth/login/login_screen.dart';
import 'package:notesapp/utils/validator.dart';
import 'package:notesapp/widgets/primary_button.dart';
import 'package:notesapp/widgets/text_input_field.dart';

import '../../../styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(),
              const SizedBox(height: 20),
              image(),
              const SizedBox(height: 48),
              emailTextField(),
              const SizedBox(height: 32),
              submitButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Text(
      'Forgot your\npassword',
      style: kNoteHeadLine.copyWith(color: textBlack),
    );
  }

  Widget image() {
    return Image.asset(
      'assets/images/accent.png',
      width: 99,
      height: 4,
    );
  }

  Widget emailTextField() {
    return TextInputField(
      controller: _emailController,
      inputAction: TextInputAction.done,
      inputType: TextInputType.emailAddress,
      validator: Validator.email,
      hintText: 'Email',
    );
  }

  Widget submitButton() {
    return CustomButton(
      buttonColor: primaryBlue,
      text: 'Submit',
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        }
      },
    );
  }
}
