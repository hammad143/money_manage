import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/responsive_setup_view.dart';

class CustomAddAmountBtn extends StatefulWidget {
  final FormState formState;

  const CustomAddAmountBtn({Key key, this.formState}) : super(key: key);

  @override
  _CustomAddAmountBtnState createState() => _CustomAddAmountBtnState();
}

class _CustomAddAmountBtnState<E> extends State<CustomAddAmountBtn> {
  Box<E> _box;
  @override
  void initState() {
    _box = Hive.box<E>(kHiveDataName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of(context);
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
        onPressed: () => _bloc.add(),
        child: Text(
          "Add Amount",
          style: Style.textStyle1
              .copyWith(fontSize: Responsive.widgetScaleFactor * 5.5),
        ),
      ),
    );
  }
}
