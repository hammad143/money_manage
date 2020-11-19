import 'package:flutter/material.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/responsive_setup_view.dart';

class CustomAppBarGradient extends StatelessWidget {
  final Widget child ;

  const CustomAppBarGradient({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return    Container(
        padding: EdgeInsets.only(
        top: Responsive.windowTopPadding * 1.2,
        bottom: Responsive.windowTopPadding / 2.5),
    decoration: BoxDecoration(
    gradient: Style.linearGradient,
    ),
      child: this.child,
    );
  }
}
