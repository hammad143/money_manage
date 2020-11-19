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
  static final textStyle3 = TextStyle(
    color: Colors.black87,
    fontSize: Responsive.textScaleFactor * 5,
    fontWeight: FontWeight.w500,
  );
  static final textStyle4 = TextStyle(
    color: Colors.black87,
    fontSize: Responsive.textScaleFactor * 2.5,
  );
  static final textStyle5 = TextStyle(
    color: Colors.black87,
    fontSize: Responsive.textScaleFactor * 3,
  );

  static final textStyle6 = TextStyle(
      fontSize: Responsive.textScaleFactor * 8,
      color: Colors.white,
      fontWeight: FontWeight.bold);
  static const linearGradient = LinearGradient(colors: [
    const Color(0xff3912db),
    const Color(0xff7a6dad),
  ]);


}
