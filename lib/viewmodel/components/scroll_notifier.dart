import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScrollNotifier extends ChangeNotifier {
  final ScrollController controller;

  ScrollNotifier(this.controller);
  void scrollNotifier() {
    controller.notifyListeners();

    notifyListeners();
  }
}
