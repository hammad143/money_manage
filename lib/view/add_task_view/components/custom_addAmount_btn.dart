import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_state.dart';

class CustomAddAmountBtn extends StatefulWidget {
  final FormState formState;
  final String  dateInString;
  final TextEditingController title, amount;
  final DropDownSelectChangeState selectedValueState;

  const CustomAddAmountBtn(
      {Key key, this.formState, this.title, this.amount, this.dateInString, this.selectedValueState})
      : super(key: key);

  @override
  _CustomAddAmountBtnState createState() => _CustomAddAmountBtnState();
}

class _CustomAddAmountBtnState<E> extends State<CustomAddAmountBtn> {
  final storageBox = Hive.box<ListOfTilesModel>(storageKey);
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
      child:  RaisedButton(
          color: Colors.transparent,
          elevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          onPressed: () {

            if (widget.formState.validate()) {
              widget.formState.save();
              _bloc.add(AddAmountInfoEvent(
                  widget.title.text, widget.amount.text, widget.dateInString,  widget.selectedValueState));

              showDialog(context: context, builder: (ctx) {
                return AlertDialog(

                  content: Align(
                    heightFactor: .5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:8.0),
                          child: const Text("Please wait, Adding your result", style: const TextStyle(color: Colors.black87),),
                        ),
                      ],
                    ),
                  ),
                );
              },);
              Timer(Duration(seconds: 5), () {
                print("Timer Called");
                Navigator.pop(context);
              });
            }
          },
          child: Text(
            "Add Amount",
            style: Style.textStyle1
                .copyWith(fontSize: Responsive.widgetScaleFactor * 5.5),
          ),
        ),

    );
  }
}
