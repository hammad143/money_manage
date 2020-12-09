import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart' as locationManager;
import 'package:money_management/model/location_model.dart';
import 'package:money_management/util/boxes_facade/boxes_facade.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/add_task_view/components/custom_addAmount_btn.dart';
import 'package:money_management/view/add_task_view/components/custom_dp_btns.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_bloc.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_event.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_state.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/check_form_submit_event.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/check_form_submit_state.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/form_submitted_bloc.dart';
import 'package:money_management/viewmodel/bloc/location_bloc/location_bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_state.dart';
import 'package:money_management/viewmodel/components/static_value_store.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm();
  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final BoxesFacade _boxesFacade = BoxesFacade();
  bool isItemSelected;
  String timeToString;
  TextEditingController _titleController, _amountController;
  FocusNode _titleFocusNode, _amountFocusNode;
  FocusScopeNode _focusScope;
  DropDownSelectChangeState dropDownState;
  bool isOptionSelected;
  Future<Map<String, dynamic>> currencies;
  String currencyValue, currencyKey;
  //final currencyBox = Hive.box(kSelectedCurrency);
  //locationManager.PermissionStatus permisisonStatus;
  LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    //locationBloc.add(LocationEvent());
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _titleFocusNode = FocusNode();
    _amountFocusNode = FocusNode();
    currencies = loadCurrenciesFile();
    currencyKey = _boxesFacade.getCurrencyBox().get(_boxesFacade.selectedCurrencyKey);

  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    //_focusScope.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> loadCurrenciesFile() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString("assets/currency/currency.json");
    final parsedData = await compute(jsonDecode, data);
    print("Data parsed into Seprate Thread $parsedData");
    return parsedData;
  }

  _onTextFieldDone([String text, FocusNode node, VoidCallback onDoneCallback]) {
    if (text.isEmpty) {
      _focusScope.requestFocus(node);
    } else
      onDoneCallback();
  }

  @override
  Widget build(BuildContext context) {
    _focusScope = FocusScope.of(context);
    //StaticValueStore.location = null;
    return BlocBuilder<CheckFormSubmitBloc, CheckFormSubmitState>(
        builder: (ctx, formCheckstate) {
      print("Check the formstate ${formCheckstate.runtimeType}");
      return BlocListener<AddAmountInfoBloc, AddAmountInfoState>(
        listener: (context, state) {
          print("checking the Add amount info state ${state.runtimeType}");
          if (state is AddAmountInfoError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                actions: [
                  FlatButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.pop(ctx),
                  )
                ],
                title: Text("${state.message}", style: Style.textStyle3),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              //Title TextField
              TextFormField(
                focusNode: _titleFocusNode,
                onFieldSubmitted: (value) {
                  _onTextFieldDone(_amountController.text, _amountFocusNode);
                },
                maxLength: 300,
                validator: _titleValidator,
                controller: _titleController,
                style: Style.textStyle1.copyWith(color: Colors.black87),
                textAlignVertical: TextAlignVertical.center,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: true,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: Responsive.textScaleFactor * 4.5),
                  hintText: "Enter a title",
                ),
              ),
              //Spacer
              SizedBox(height: Responsive.widgetScaleFactor * 4),
              //Amount TextField
              TextFormField(
                validator: _amountValidator,
                maxLength: 20,
                focusNode: _amountFocusNode,
                controller: _amountController,
                style: Style.textStyle1.copyWith(color: Colors.black87),
                textAlignVertical: TextAlignVertical.center,
                keyboardAppearance: Brightness.dark,
                keyboardType: TextInputType.number,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                onFieldSubmitted: (value) {
                  _onTextFieldDone(_titleController.text, _titleFocusNode);
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: Responsive.textScaleFactor * 4.5),
                  hintText: "Enter an amount",
                ),
              ),
              FutureBuilder<Map<String, dynamic>>(
                  future: currencies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //final currency = currencyBox.get("currency");
                      if (currencyKey != null)
                        currencyValue =
                            snapshot.data[currencyKey]['symbol_native'];
                    }

                    return DropdownButton(
                      value: currencyKey,
                      isExpanded: true,
                      hint: Text("Select a Currency",
                          style:
                              Style.textStyle1.copyWith(color: Colors.black54)),
                      onChanged: (value) {
                        print("$value on Changed");
                        currencyKey = value;
                        currencyValue =
                            snapshot.data[currencyKey]['symbol_native'];
                        print("CurrencyValue ${currencyValue}");
                        _boxesFacade.getCurrencyBox().put(_boxesFacade.selectedCurrencyKey, currencyValue);
                        //currencyValue = snapshot.data[value]['symbol_native'];
                      },
                      items: <DropdownMenuItem>[
                        if (snapshot.hasData)
                          for (String key in snapshot.data.keys)
                            DropdownMenuItem(
                              onTap: () {},
                              value: key,
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      "${snapshot.data[key]['symbol_native']}",
                                      style: Style.textStyle1.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      " ${snapshot.data[key]['name']}",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize:
                                              Responsive.textScaleFactor * 4),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      ],
                    );
                  }),
              //Spacer
              SizedBox(height: Responsive.widgetScaleFactor * 4),
              //Date Container
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    width: 1.7,
                    color: const Color(0xff6324a3),
                  ),
                )),
                child: InkWell(
                  onTap: () => _onTimeAndDatePickerPressed(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<DateTimePickBloc, DateTimePickState>(
                          builder: (ctx, state) {
                        if (state is DateTimePickInitialState)
                          timeToString = _onTimeChangeState(state);
                        else if (state is DateTimePickedState)
                          timeToString = _onTimeChangeState(state);

                        return Text(timeToString,
                            style: Style.textStyle1
                                .copyWith(color: Colors.black54));
                      }),
                      Material(
                        shape: CircleBorder(),
                        type: MaterialType.transparency,
                        child: Icon(
                          Icons.date_range,
                          color: const Color(0xff6324a3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Spacer
              SizedBox(height: Responsive.widgetScaleFactor * 4),
              BlocBuilder<DropDownSelectChangeBloc, DropDownSelectChangeState>(
                  builder: (ctx, state) {
                bool option;
                dropDownState = state;
                print("Check State ${formCheckstate.isFormSubmit}");
                if (dropDownState != null) isOptionSelected = true;
                /*else
                          isOptionSelected = false;*/

                return Column(
                  children: [
                    DropDownBtns(
                        value: formCheckstate.isFormSubmit
                            ? dropDownState?.value
                            : null),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        height: (isOptionSelected == null || isOptionSelected)
                            ? 0
                            : null,
                        duration: Duration(milliseconds: 500),
                        child: Text("Option is to be selected",
                            style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: Responsive.widgetScaleFactor * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Location is : ${StaticValueStore.isLocationOn ? "On" : "Off"}",
                    style: Style.textStyle3.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  Switch(
                      activeColor: const Color(0xff5e10c4),
                      value: StaticValueStore.isLocationOn,
                      onChanged: (value) {})
                ],
              ),
              SizedBox(height: Responsive.widgetScaleFactor * 4),
              SizedBox(height: Responsive.widgetScaleFactor * 4),
              CustomAddAmountBtn(
                onBtnPressed: () {

                      Timer(Duration(seconds: 3), () {
                        _titleController.value = TextEditingValue.empty;
                        _amountController.value = TextEditingValue.empty;
                        BlocProvider.of<CheckFormSubmitBloc>(context)
                            .add(CheckFormSubmitEvent(false));

                        Navigator.pop(context);
                      });
                    }


              )],
          ),
        ),
      );
    });
  }

  String _amountValidator(String value) {
    final isOnlyNumbers = value.contains(RegExp(r"^\d+$"));
    if (!isOnlyNumbers && value.isNotEmpty)
      return "Enter only digits";
    else if (value.isEmpty) return "Amount required";
    return null;
  }

  String _titleValidator(value) {
    if (value.length == 300)
      return "Title cannot exceeds more than 300 chars";
    else if (value.isEmpty) return "Title is required";
    return null;
  }

  String _onTimeChangeState(state) {
    final year = state.date.year,
        month = state.date.month,
        day = state.date.day;
    final hour = state.date.hour, minutes = state.date.minute;
    return "$month/$day/$year - $hour:$minutes";
  }

  void _onTimeAndDatePickerPressed(BuildContext context) async {
    final todayDate = DateTime.now();
    final currentTime = TimeOfDay.now();
    final timeAndDate = await showDateAndTimePicker(context);
    final datePicker = timeAndDate[0] as DateTime;
    final timePicker = timeAndDate[1] as TimeOfDay;

    final currentTimeWithDate = DateTime(todayDate.year, todayDate.month,
        todayDate.day, currentTime.hour, currentTime.minute);
    DateTime settedTime = currentTimeWithDate;
    final isTimeSet = currentTime == timePicker;

    if (datePicker == null) {
      if (timePicker != null) {
        print("${timePicker.hour} and ${timePicker.minute}");
        final d = DateTime(todayDate.year, todayDate.month, todayDate.day,
            timePicker.hour, timePicker.minute);
        BlocProvider.of<DateTimePickBloc>(context).add(DateTimePickEvent(d));
      } else {
        BlocProvider.of<DateTimePickBloc>(context)
            .add(DateTimePickEvent(settedTime));
      }
    } else if (timePicker == null) {
      settedTime = DateTime(datePicker.year, datePicker.month, datePicker.day,
          currentTime.hour, currentTime.minute);
      BlocProvider.of<DateTimePickBloc>(context)
          .add(DateTimePickEvent(settedTime));
    } else {
      settedTime = DateTime(datePicker.year, datePicker.month, datePicker.day,
          timePicker.hour, timePicker.minute);
      BlocProvider.of<DateTimePickBloc>(context)
          .add(DateTimePickEvent(settedTime));
    }
  }

  Future<List<dynamic>> showDateAndTimePicker(BuildContext context) async {
    final datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1997),
      lastDate: DateTime.now()..year,
    );
    final timePicker = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
        cancelText: "Close",
        confirmText: "Set",
        helpText: "Pick your time");
    return [datePicker, timePicker];
  }
}
