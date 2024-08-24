import 'package:chat_app/core/common/widgets/custom_button/custom_buttons.dart';
import 'package:chat_app/core/common/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return '';
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
              validator: _validator,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: _passwordController,
              hintText: "example123",
              label: "Password",
              prefixIcon: const Icon(Icons.lock),
              validator: _validator,
            ),
            const SizedBox(
              height: 70,
            ),
            CustomButtons(
              onPressed: () {},
              text: "Sign In",
            )
          ],
        ),
      ),
    );
  }
}
