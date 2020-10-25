import 'package:flutter/cupertino.dart';

class Responsive {
  static double _deviceWidth,
      _deviceHeight,
      _deviceBlockWidth,
      _deviceBlockHeight,
      _widgetScaleFactor,
      _textScaleFactor;

  static void init(BuildContext context) {
    final data = MediaQuery.of(context);
    _deviceWidth = data.size.width;
    _deviceHeight = data.size.height;
    _deviceBlockWidth = _deviceWidth / 100;
    _deviceBlockHeight = _deviceHeight / 100;
    if (data.orientation == Orientation.landscape)
      _widgetScaleFactor = _deviceBlockHeight;
    else
      _widgetScaleFactor = _deviceBlockWidth;
    _textScaleFactor = _widgetScaleFactor;
  }
}
