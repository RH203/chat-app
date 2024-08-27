import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.validator,
    required this.prefixIcon,
    this.keyboardType,
    this.autoCorrect = true,
    this.textCapitalization = TextCapitalization.none,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final bool isPassword;
  final String label;
  final String hintText;
  final Widget prefixIcon;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool autoCorrect;
  final TextCapitalization textCapitalization;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _show = true;

  void _onPressed() {
    setState(() {
      _show = !_show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      autocorrect: widget.autoCorrect,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      obscureText: widget.isPassword ? _show : false,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: _onPressed,
                icon: _show
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : null,
        label: Text(widget.label),
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
          ),
        ),
      ),
    );
  }
}
