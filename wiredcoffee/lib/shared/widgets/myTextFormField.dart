import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  const MyTextFormField(
      {super.key, required this.name, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: name,
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0)),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
