import 'package:flutter/material.dart';
import 'package:notesapp/utils/validator.dart';
import 'package:notesapp/widgets/password_input_field.dart';
import 'package:notesapp/widgets/primary_button.dart';
import 'package:notesapp/widgets/text_input_field.dart';

import '../../../styles.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                forgotPassword(),
                const SizedBox(height: 32),
                loginButton(),
                const SizedBox(height: 50),
                createAccount(),
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
      'Login to your\naccount',
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
      inputAction: TextInputAction.done,
      obscureText: _showPassword,
      validator: Validator.password,
      toggle: () => setState(() => _showPassword = !_showPassword),
      hintText: 'Password',
    );
  }

  Widget forgotPassword() {
    return InkWell(
      onTap: () {},
      child: Text(
        'Forgot Password?',
        style: kNoteRegular.copyWith(color: primaryBlue),
      ),
    );
  }

  Widget loginButton() {
    return CustomButton(
      buttonColor: primaryBlue,
      text: 'Login',
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState!.validate()) {

        }
      },
    );
  }

  Widget createAccount() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: 'Don\'t have an account? ',
          style: kNoteRegular.copyWith(color: textGrey),
          children: [
            WidgetSpan(
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Register.',
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
