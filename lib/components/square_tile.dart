import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
    // required List<Column> children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image.asset(
        imagePath,
        // height: 150,
        // width: 300,
      ),
    );
  }
}
