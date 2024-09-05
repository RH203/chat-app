import 'package:chat_app/app_logger.dart';
import 'package:chat_app/core/common/widgets/custom_button/custom_buttons.dart';
import 'package:chat_app/core/common/widgets/custom_text_field/custom_text_field.dart';
import 'package:chat_app/core/injection/injection.dart';
import 'package:chat_app/core/utils/helper_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: LoadingAnimationWidget.beat(
            color: Colors.blueAccent,
            size: 150,
          ),
        );
      },
    );

    try {
      final _signIn = await getIt<FirebaseAuth>().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) context.go('/chat-screen');
    } on FirebaseAuthException catch (message) {
      AppLogger.error(message);

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${message.message}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (message) {
      AppLogger.error(message);
    } finally {
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 100),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomTextField(
                controller: _emailController,
                hintText: "example@gmail.com",
                label: "Email",
                prefixIcon: const Icon(Icons.email),
                validator: getIt<HelperValidator>().validateEmail,
                keyboardType: TextInputType.emailAddress,
                autoCorrect: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: "example123",
                label: "Password",
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.lock),
                validator: getIt<HelperValidator>().validatePassword,
                autoCorrect: false,
                isPassword: true,
              ),
              const SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => context.go('/sign-up'),
                  child: const Text(
                    'Doesn\'t have account?',
                  ),
                ),
              ),
              CustomButtons(
                onPressed: _onSubmit,
                text: "Sign In",
              )
            ],
          ),
        ),
      ),
    );
  }
}
