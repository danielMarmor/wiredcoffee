import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  final String name;
  final TextEditingController controller;
  const PasswordTextFormField({
    super.key,
    required this.name,
    required this.controller,
  });

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.name,
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0)),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
                _obscureText == true ? Icons.visibility : Icons.visibility_off,
                color: Colors.black)),
      ),
    );
  }
}
