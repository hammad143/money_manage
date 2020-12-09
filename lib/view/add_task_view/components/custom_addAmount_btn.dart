import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';

class CustomAddAmountBtn extends StatefulWidget {
  final VoidCallback onBtnPressed;

  const CustomAddAmountBtn({Key key, this.onBtnPressed}) : super(key: key);

  @override
  _CustomAddAmountBtnState createState() => _CustomAddAmountBtnState();
}

class _CustomAddAmountBtnState<E> extends State<CustomAddAmountBtn> {
  //final storageBox = Hive.box<ListOfTilesModel>(storageKey);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<AddAmountInfoBloc>(context);
    return Container(
      height: Responsive.widgetScaleFactor * 17,
      width: Responsive.widgetScaleFactor * 60,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xffe0e0e0),
            blurRadius: 3,
          )
        ],
        gradient: Style.linearGradient,
      ),
      child: RaisedButton(
        color: Colors.transparent,
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        onPressed: widget.onBtnPressed,
        child: Text(
          "Add Amount",
          style: Style.textStyle1
              .copyWith(fontSize: Responsive.widgetScaleFactor * 5.5),
        ),
      ),
    );
  }
}
