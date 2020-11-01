import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_event.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_state.dart';

class DropDownBtns extends StatelessWidget {
  final int value;
  const DropDownBtns({
    Key key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


      return DropdownButton(
        isExpanded: true,
        isDense: false,
        style: Style.textStyle3,
        value: value,
        hint: Text("Amount Received/Spent"),
        onChanged: (value) => BlocProvider.of<DropDownSelectChangeBloc>(context)
            .add(DropDownSelectChangeEvent(value)),
        onTap: () {},
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
