import 'package:flutter/material.dart';

class AdvertCard extends StatelessWidget {
  final String image;
  const AdvertCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        // color: Colors.amber,
        width: 270,
        child: Image.asset(
          image,
          fit: BoxFit.fill,
          // width: 150,
          // height: 150,
        ),
      ),
    );
  }
}
