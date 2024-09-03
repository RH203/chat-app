import 'package:chat_app/app_logger.dart';
import 'package:chat_app/core/injection/injection.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_app/core/utils/helper_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/core/common/widgets/custom_button/custom_buttons.dart';
import 'package:chat_app/core/common/widgets/custom_text_field/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _fullnameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _fullnameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      UserCredential _signUp =
          await getIt<FirebaseAuth>().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = _signUp.user;

      if (user != null) {
        await user.updateDisplayName(_fullnameController.text);
        await user.reload();
      }

      if (mounted) context.go('/chat-screen');
    } on FirebaseAuthException catch (message) {
      AppLogger.error("${message.email} - ${message.message}");
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_emailController.text} - ${message.message}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (message) {
      AppLogger.error(message);
    } finally {
      if (mounted) context.pop();
    }
  }

  void _showModalDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Up Successful'),
          content: const Text(
              'You have successfully signed up. Please sign in to continue.'),
          actions: [
            ElevatedButton(
              onPressed: () => context.go('/sign-in'),
              child: const Text('Sign In'),
            )
          ],
        );
      },
    );
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
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
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
                controller: _fullnameController,
                hintText: "Your name",
                label: "Full name",
                prefixIcon: const Icon(Icons.person_2),
                validator: getIt<HelperValidator>().validateUsername,
                keyboardType: TextInputType.text,
                autoCorrect: false,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: "example123",
                label: "Password",
                prefixIcon: const Icon(Icons.lock),
                validator: getIt<HelperValidator>().validatePassword,
                keyboardType: TextInputType.text,
                autoCorrect: false,
                isPassword: true,
              ),
              const SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => context.go('/sign-in'),
                  child: const Text(
                    'Already have account?',
                  ),
                ),
              ),
              CustomButtons(
                onPressed: _onSubmit,
                text: "Sign Up",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
