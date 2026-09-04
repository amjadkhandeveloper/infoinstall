import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle heading1({
    required BuildContext context,
    Color? color,
    bool isBold = false,
  }) {
    // Customize and return a TextStyle object
    return TextStyle(
      color: color,
      fontSize: 24,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );
  }

  static TextStyle heading2({
    required BuildContext context,
    Color? color,
    bool isBold = false,
  }) {
    // Customize and return a TextStyle object
    return TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );
  }

  static TextStyle title1({
    required BuildContext context,
    Color? color,
    bool isBold = false,
  }) {
    // Customize and return a TextStyle object
    return TextStyle(
      color: color,
      fontSize: 20,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );
  }

  static TextStyle title2({
    required BuildContext context,
    Color? color,
    bool isBold = false,
  }) {
    // Customize and return a TextStyle object
    return TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
    );
  }

  static TextStyle title3({
    required BuildContext context,
    Color? color,
    bool isBold = false,
  }) {
    // Customize and return a TextStyle object
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
    );
  }

  static TextStyle subTitle1({
    required BuildContext context,
    Color? color,
    bool isBold = false,
  }) {
    // Customize and return a TextStyle object
    return TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );
  }

  static TextStyle subTitle2({
    required BuildContext context,
    Color? color,
    bool isBold = false,
  }) {
    // Customize and return a TextStyle object
    return TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
    );
  }
}
