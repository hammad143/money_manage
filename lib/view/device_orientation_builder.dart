import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
  final Widget portrait, landscape;

  const OrientationLayout({Key key, this.portrait, this.landscape})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return data.orientation == Orientation.landscape
        ? landscape ?? Container()
        : portrait ?? Container();
  }
}
