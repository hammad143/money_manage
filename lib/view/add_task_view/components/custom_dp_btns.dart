import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/check_form_submit_event.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/form_submitted_bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_event.dart';

class DropDownBtns extends StatelessWidget {
  final String hintTitle;
  final int value;
  final bool isFormSubmitted;
  final Function(int) onItemChange;
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
      onChanged: (value) => onItemChange,
      /*  BlocProvider.of<DropDownSelectChangeBloc>(context)
            .add(DropDownSelectChangeEvent(value));
        BlocProvider.of<CheckFormSubmitBloc>(context)
            .add(CheckFormSubmitEvent(true));*/

      onTap:onTap,
      items: [
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
      ],
    );
  }
}
