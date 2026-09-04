import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/print_mixin.dart';

class CommonUpdate with PrintMixin {
  static final CommonUpdate _singletonInstance = CommonUpdate.internal();

  factory CommonUpdate() {
    return _singletonInstance;
  }

  CommonUpdate.internal() {
    //initialze any thing here.
  }

  // Example method to demonstrate operations
  void someMethod() {
    p("This is a method in the singleton class.");
  }

  final ValueNotifier<double> variableName = ValueNotifier<double>(100);
}
