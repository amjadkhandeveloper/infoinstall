
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToast({
  required String message,
  Color? color,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
