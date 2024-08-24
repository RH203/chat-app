import 'package:flutter/material.dart';
import 'package:chat_app/core/common/widgets/custom_button/custom_buttons.dart'; // Pastikan ini sesuai dengan struktur folder dan file
import 'package:chat_app/core/common/widgets/custom_text_field/custom_text_field.dart'; // Pastikan ini sesuai dengan struktur folder dan file

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                "Sign Up",
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
              text: "Sign Up",
            ),
          ],
        ),
      ),
    );
  }
}
