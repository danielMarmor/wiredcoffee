import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String imageSrc;
  const CategoryItem({super.key, required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.brown[400],
        child: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(imageSrc),
        )
        // child: Image(
        //   width: 30,
        //   height: 30,
        //   image:
        //   fit: BoxFit.fill,
        // ),
        //backgroundImage: AssetImage('assets/scirt.png'),
        );
  }
}
