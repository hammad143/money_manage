import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/view/responsive_setup_view.dart';

class CustomAnimatedContainer extends StatefulWidget {
  const CustomAnimatedContainer(
      {Key key, @required this.isTapped, this.onPressed})
      : super(key: key);

  final bool isTapped;
  final VoidCallback onPressed;

  @override
  _CustomAnimatedContainerState createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {
  final priceBox = Hive.box<ListOfTilesModel>(storageKey);
  final counterKeyBox = Hive.box<int>(counterKey);
  Future<List<double>> totalFutureAmount;
  double totalAmount = 0;
  @override
  void initState() {
    super.initState();
  }

  Future<List<double>> totalPrice() {
    double receivedAmount = 0;
    double spentAmount = 0;
    double lostAmount = 0;
    String source;
    for (int i = 0; i < counterKeyBox.length; i++) {
      if (priceBox.get(i)?.option == "Received") {
        source = priceBox.get(i).amount;
        receivedAmount += double.parse(source);
      } else if (priceBox.get(i)?.option == "Spent") {
        source = priceBox.get(i).amount;
        spentAmount += double.parse(source);
      } else if (priceBox.get(i)?.option == "Lost") {
        source = priceBox.get(i).amount;
        lostAmount += double.parse(source);
      }
    }
    final x = Future.value([receivedAmount, spentAmount, lostAmount]);

    return x;
  }

  @override
  Widget build(BuildContext context) {
    totalFutureAmount = totalPrice();
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),

        //alignment: Alignment.centerLeft,
        padding: widget.isTapped
            ? EdgeInsets.symmetric(vertical: kDefaultPadding / 2.5)
            : EdgeInsets.symmetric(vertical: 0, horizontal: 0),

        width: widget.isTapped
            ? Responsive.deviceBlockWidth * 80
            : Responsive.deviceBlockWidth * 8,
        decoration: BoxDecoration(
          //color: Colors.white.withOpacity(.9),
          color: widget.isTapped ? const Color(0xff5d28b8) : Colors.transparent,
          shape: widget.isTapped ? BoxShape.rectangle : BoxShape.circle,
          boxShadow: !widget.isTapped
              ? [
                  const BoxShadow(
                    blurRadius: 10,
                    color: Color(0xff3f30b3),
                    offset: Offset(0, 2),
                    spreadRadius: 7,
                  ),
                  const BoxShadow(
                    blurRadius: 10,
                    color: Color(0xff373ccc),
                    offset: Offset(0, 2),
                    spreadRadius: 6,
                  ),
                  const BoxShadow(
                    blurRadius: 10,
                    color: Color(0xffb32957),
                    offset: Offset(0, 2),
                    spreadRadius: 5,
                  ),
                  const BoxShadow(
                    blurRadius: 10,
                    color: Color(0xff373ccc),
                    offset: Offset(0, 2),
                    spreadRadius: 3,
                  ),
                ]
              : [
                  const BoxShadow(
                    blurRadius: 1,
                    color: Color(0xff4a4a4a),
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
        ),
        child: FutureBuilder(
            future: totalFutureAmount,
            builder: (ctx, snapShot) {
              final data = snapShot.data;

              return Text(
                widget.isTapped
                    ? "Received:\$${data != null ? data[0] : 0}\n Spent \$${data != null ? data[1] : 0}\n Lost \$${data != null ? data[2] : 0}\n"
                    : "\$",
                textAlign: TextAlign.center,
                style: TextStyle(
                  //height: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: widget.isTapped
                      ? Responsive.textScaleFactor * 4.5
                      : Responsive.textScaleFactor * 8,
                ),
              );
            }),
      ),
    );
  }
}
