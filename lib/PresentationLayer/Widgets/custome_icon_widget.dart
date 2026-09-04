import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String iconName;
  final Color color;
  final double height;
  final double width;
  const CustomIcon({
    super.key,
    required this.iconName,
    this.color = Colors.grey,
    this.height = 24,
    this.width = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          "assets/images/icons/$iconName",
          color: color,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
