import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String name;
  final Function(BuildContext context) submit;
  const MyButton({super.key, required this.name, required this.submit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.0,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0.0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.0))),
              backgroundColor: Colors.blueGrey[400],
              foregroundColor: Colors.white),
          onPressed: () {
            submit(context);
          },
          child: Text(name, style: const TextStyle(fontSize: 18.0))),
    );
  }
}
