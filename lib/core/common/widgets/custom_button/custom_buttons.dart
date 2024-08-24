import 'package:flutter/material.dart';

class CustomButtons extends StatefulWidget {
  const CustomButtons({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final void Function() onPressed;

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        splashFactory: InkSplash.splashFactory,
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 27,
        ),
      ),
    );
  }
}
