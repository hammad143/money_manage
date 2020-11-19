import 'package:flutter/cupertino.dart';

class Responsive {
  static double _deviceWidth,
      _deviceHeight,
      _deviceBlockWidth,
      _deviceBlockHeight,
      _widgetScaleFactor,
      _textScaleFactor,
      _windowTopPadding,
      _windowBottomPadding,
      _windowLeftPadding,
      _windowRightPadding;

  static void init(BuildContext context) {
    final data = MediaQuery.of(context);
    _windowTopPadding = data.padding.top;
    _windowBottomPadding = data.padding.bottom;
    _windowLeftPadding = data.padding.left;
    _windowRightPadding = data.padding.right;
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

  static double get deviceWidth => _deviceWidth;
  static double get deviceHeight => _deviceHeight;
  static double get deviceBlockWidth => _deviceBlockWidth;
  static double get deviceBlockHeight => _deviceBlockHeight;
  static double get widgetScaleFactor => _widgetScaleFactor;
  static double get textScaleFactor => _textScaleFactor;
  static double get windowTopPadding => _windowTopPadding;
  static double get windowBottomPadding => _windowBottomPadding;
  static double get windowLeftPadding => _windowLeftPadding;
  static double get windowRightPadding => _windowRightPadding;
}
