import 'package:flutter/material.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/screens/auth/login/login_screen.dart';
import 'package:notesapp/screens/home/home_screen.dart';
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
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
      S.current.alreadyHaveAccount,
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
      hintText: S.current.email,
    );
  }

  Widget passwordTextField() {
    return PasswordInputField(
      controller: _passwordController,
      inputAction: TextInputAction.next,
      obscureText: _obscurePassword,
      validator: Validator.password,
      toggle: () => setState(() => _obscurePassword = !_obscurePassword),
      hintText: S.current.password,
    );
  }

  Widget confirmPasswordTextField() {
    return PasswordInputField(
      controller: _confirmPasswordController,
      inputAction: TextInputAction.done,
      obscureText: _obscureConfirmPassword,
      validator: (String? value) {
        if (value!.isEmpty) {
          return S.current.confirmPassword;
        }

        if (_passwordController.text != _confirmPasswordController.text) {
          return S.current.passwordsDoNotMatch;
        }

        return null;
      },
      toggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
      hintText: S.current.confirmPassword,
    );
  }

  Widget registerButton() {
    return CustomButton(
      buttonColor: primaryBlue,
      text: S.current.register,
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        }
      },
    );
  }

  Widget loginAccount() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: S.current.alreadyHaveAccount,
          style: kNoteRegular.copyWith(color: textGrey),
          children: [
            WidgetSpan(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: Text(
                  S.current.login,
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
