import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String imageSrc;
  final String name;
  final double price;
  const SingleProduct(
      {super.key,
      required this.imageSrc,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: SizedBox(
        width: 160.0,
        // decoration: BoxDecoration(
        //     color: Colors.transparent,
        //     border: Border.all(width: 1.0, color: Colors.black)),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image(
                width: double.infinity,
                height: double.infinity,
                image: NetworkImage(
                  imageSrc,
                ),
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                fit: BoxFit.fill,
              ),
              // decoration: BoxDecoration(
              //     color: Colors.transparent,
              //     border: Border.all(width: 1.0, color: Colors.black)),
            ),
            Container(
              width: double.infinity,
              height: 25,
              alignment: Alignment.center,
              child: Text(
                name,
                style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 0),
            Container(
              width: double.infinity,
              height: 25,
              alignment: Alignment.center,
              child: Text(
                "USD $price",
                style: const TextStyle(fontSize: 17.0, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
