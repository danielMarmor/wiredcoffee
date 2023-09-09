import 'package:flutter/material.dart';

class SwitchScreen extends StatelessWidget {
  final String name;
  final String whichAccount;
  final void Function()? onTap;
  const SwitchScreen(
      {super.key,
      required this.name,
      required this.whichAccount,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: <Widget>[
          Text(whichAccount,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              )),
          const SizedBox(width: 10.0),
          GestureDetector(
            onTap: onTap,
            child: Text(name,
                style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
