import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;

  final Color buttonColor;
  const CustomButton(
      {Key? key,
      required this.innerText,
      required this.onPressed,
      required this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          innerText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
