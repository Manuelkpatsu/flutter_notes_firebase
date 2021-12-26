import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/generated/l10n.dart';
import 'package:notesapp/utils/validator.dart';
import 'package:notesapp/widgets/password_input_field.dart';
import 'package:notesapp/widgets/primary_button.dart';
import 'package:notesapp/widgets/text_input_field.dart';

import '../../../locator.dart';
import '../../../styles.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_listenable.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginBloc bloc;
  final eventController = StreamController<LoginEvent>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    bloc = get<LoginBloc>(param1: context, param2: eventController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
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
      S.current.loginToAccount,
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
      inputAction: TextInputAction.done,
      obscureText: _obscurePassword,
      validator: Validator.password,
      toggle: () => setState(() => _obscurePassword = !_obscurePassword),
      hintText: S.current.password,
    );
  }

  Widget forgotPassword() {
    return InkWell(
      onTap: () {
        eventController.add(GoToForgotPasswordScreenEvent());
      },
      child: Text(
        S.current.forgotPassword,
        style: kNoteRegular.copyWith(color: primaryBlue),
      ),
    );
  }

  Widget loginButton() {
    return CustomButton(
      buttonColor: primaryBlue,
      child: ValueListenableBuilder<bool>(
        valueListenable: bloc.progressIndicator,
        builder: (context, show, child) {
          return show
              ? const CircularProgressIndicator()
              : Text(
                  S.current.login,
                  style: kNoteHeading5.copyWith(color: Colors.white),
                );
        },
      ),
      textColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          eventController.add(
            LoginUserEvent(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            ),
          );
        }
      },
    );
  }

  Widget createAccount() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: S.current.doNotHaveAccount,
          style: kNoteRegular.copyWith(color: textGrey),
          children: [
            WidgetSpan(
              child: InkWell(
                onTap: () {
                  eventController.add(GoToSignUpScreenEvent());
                },
                child: Text(
                  S.current.register,
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
