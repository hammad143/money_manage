import 'package:flutter/material.dart';
import 'package:money_management/util/constants/style.dart';

class DropDownBtns extends StatelessWidget {
  final String hintTitle;
  final int value;
  final bool isFormSubmitted;
  final Function(dynamic) onItemChange;
  final VoidCallback onTap;
  final List<DropdownMenuItem> items;
  const DropDownBtns({
    Key key,
    this.items,
    this.onItemChange,
    this.onTap,
    this.value,
    this.hintTitle,
    this.isFormSubmitted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      //isDense: false,

      style: Style.textStyle3,
      value: value,
      hint: Text("$hintTitle"),
      onChanged: onItemChange,
      /*  BlocProvider.of<DropDownSelectChangeBloc>(context)
            .add(DropDownSelectChangeEvent(value));
        BlocProvider.of<CheckFormSubmitBloc>(context)
            .add(CheckFormSubmitEvent(true));*/

      onTap: onTap,
      items:
          items, /*[
        DropdownMenuItem(
          value: 0,
          child: Text("Spent"),
          onTap: () {},
        ),
        DropdownMenuItem(
          value: 1,
          child: Text("Received"),
          onTap: () {},
        ),
        DropdownMenuItem(
          value: 2,
          child: Text("Lost"),
          onTap: () {},
        ),
      ],*/
    );
  }
}
