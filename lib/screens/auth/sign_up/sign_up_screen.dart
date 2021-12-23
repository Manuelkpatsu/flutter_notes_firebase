import 'package:flutter/material.dart';
import 'package:notesapp/utils/validator.dart';
import 'package:notesapp/widgets/password_input_field.dart';
import 'package:notesapp/widgets/primary_button.dart';
import 'package:notesapp/widgets/text_input_field.dart';

import '../../../styles.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign_up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
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
                passwordTextField(),
                const SizedBox(height: 32),
                confirmPasswordTextField(),
                const SizedBox(height: 32),
                registerButton(),
                const SizedBox(height: 50),
                loginAccount(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Text(
      'Register new\naccount',
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
      inputAction: TextInputAction.next,
      inputType: TextInputType.emailAddress,
      validator: Validator.email,
      hintText: 'Email',
    );
  }

  Widget passwordTextField() {
    return PasswordInputField(
      controller: _passwordController,
      inputAction: TextInputAction.next,
      obscureText: _showPassword,
      validator: Validator.password,
      toggle: () => setState(() => _showPassword = !_showPassword),
      hintText: 'Password',
    );
  }

  Widget confirmPasswordTextField() {
    return PasswordInputField(
      controller: _confirmPasswordController,
      inputAction: TextInputAction.done,
      obscureText: _showConfirmPassword,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please confirm password';
        }

        if (_passwordController.text != _confirmPasswordController.text) {
          return "Passwords do not match";
        }

        return null;
      },
      toggle: () => setState(() => _showConfirmPassword = !_showConfirmPassword),
      hintText: 'Confirm Password',
    );
  }

  Widget registerButton() {
    return CustomButton(
      buttonColor: primaryBlue,
      text: 'Register',
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState!.validate()) {

        }
      },
    );
  }

  Widget loginAccount() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: 'Already have an account? ',
          style: kNoteRegular.copyWith(color: textGrey),
          children: [
            WidgetSpan(
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Login.',
                  style: kNoteRegular.copyWith(color: primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
