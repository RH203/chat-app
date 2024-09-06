import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        splashFactory: InkSplash.splashFactory,
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 27,
        ),
      ),
    );
  }
}
