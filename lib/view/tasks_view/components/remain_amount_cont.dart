import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/view/tasks_view/components/custom_animated_cont.dart';

class RemainingAmountContainer extends StatefulWidget {
  @override
  _RemainingAmountContainerState createState() =>
      _RemainingAmountContainerState();
}

class _RemainingAmountContainerState extends State<RemainingAmountContainer> {
  bool isTapped = false;
  double dx, dy;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      //top: dy ?? ,
      top: dy ??
          (Responsive.deviceHeight - MediaQuery.of(context).padding.bottom) -
              Responsive.deviceBlockHeight * 20,
      left: dx ?? Responsive.deviceBlockWidth * 45,

      child: Align(
        alignment: Alignment.center,
        child: Draggable(
          feedback: Material(
            child: CustomAnimatedContainer(
              isTapped: isTapped,
              onPressed: onGestureTapped,
            ),
          ),
          child: CustomAnimatedContainer(
              isTapped: isTapped, onPressed: onGestureTapped),
          feedbackOffset: Offset(Responsive.deviceBlockWidth * 80,
              Responsive.deviceBlockHeight * 80),
          onDragStarted: () {
            print("Dragging");
          },
          onDragEnd: (draggableDetails) {
            dx = draggableDetails.offset.dx;
            dy = draggableDetails.offset.dy;
            //Dx Tapped Or/Not Tapped
            final whenDxTapped =
                Responsive.deviceWidth - Responsive.deviceBlockWidth * 80;
            final whenDxNotTapped =
                Responsive.deviceWidth - Responsive.deviceBlockWidth * 10;
            //Dy Tapped Or/Not Tapped
            final whenDyTapped =
                Responsive.deviceHeight - Responsive.deviceBlockHeight * 15;
            final whenDyNotTapped =
                Responsive.deviceHeight - Responsive.deviceBlockHeight * 10;
            if (dx < 0) dx = 0;
            if (dx > (isTapped ? whenDxTapped : whenDxNotTapped))
              dx = isTapped ? whenDxTapped : whenDxNotTapped;
            if (dy < 0) dy = 0;
            if (dy > (isTapped ? whenDyTapped : whenDyNotTapped))
              dy = isTapped ? whenDyTapped : whenDyNotTapped;

            setState(() {
              print(
                  "$dx and $dy and ${Responsive.deviceWidth} and ${Responsive.deviceHeight}");
            });
          },
        ),
      ),
    );
  }

  onGestureTapped() {
    setState(() {
      print("Tapped");
      isTapped = !isTapped;
    });
  }
}
