import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/view/responsive_setup_view.dart';

class Style {
  static final textStyle1 = TextStyle(
    color: Colors.white,
    fontSize: Responsive.textScaleFactor * 5,
    fontWeight: FontWeight.w500,
  );
  static final textStyle2 = TextStyle(
    color: Colors.white,
    fontSize: Responsive.textScaleFactor * 3,
  );
  static const linearGradient = LinearGradient(colors: [
    const Color(0xff3912db),
    const Color(0xff7a6dad),
  ]);
}
