import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/add_task_view/components/custom_addAmount_btn.dart';
import 'package:money_management/view/add_task_view/components/custom_dp_btns.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_bloc.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_event.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_state.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm();
  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController, _amountController;
  FocusNode _titleFocusNode, _amountFocusNode;
  FocusScopeNode _focusScope;
  bool _isFocused = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _titleFocusNode = FocusNode(debugLabel: 'TextField');
    _amountFocusNode = FocusNode();
    if (_isFocused) {
      _titleFocusNode.unfocus();
      _amountFocusNode.unfocus();
    }
  }

  @override
  void didChangeDependencies() {
    print("Did DependacyChange");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _focusScope.dispose();
    super.dispose();
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: true,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: Responsive.textScaleFactor * 4.5),
              hintText: "Enter a title",
            ),
          ),
          SizedBox(height: Responsive.widgetScaleFactor * 4),
          TextFormField(
            validator: _amountValidator,
            maxLength: 20,
            focusNode: _amountFocusNode,
            controller: _amountController,
            onFieldSubmitted: (value) {
              _onTextFieldDone(_titleController.text, _titleFocusNode);
            },
            style: Style.textStyle1.copyWith(color: Colors.black87),
            textAlignVertical: TextAlignVertical.center,
            keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: Responsive.textScaleFactor * 4.5),
              hintText: "Enter an amount",
              prefixIconConstraints:
                  BoxConstraints(minWidth: 23, maxHeight: 20),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.attach_money_outlined,
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.widgetScaleFactor * 4),
          Container(
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(
                width: 1.7,
                color: const Color(0xff6324a3),
              ),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<DateTimePickBloc, DateTimePickState>(
                    builder: (ctx, state) {
                  String timeToString;

                  if (state is DateTimePickInitialState)
                    timeToString = _onTimeChangeState(state);
                  else if (state is DateTimePickedState)
                    timeToString = _onTimeChangeState(state);

                  return Text(timeToString,
                      style: Style.textStyle1.copyWith(color: Colors.black54));
                }),
                Material(
                  shape: CircleBorder(),
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      color: const Color(0xff6324a3),
                    ),
                    onPressed: () => _onTimeAndDatePickerPressed(context),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.widgetScaleFactor * 4),
          DropDownBtns(),
          SizedBox(height: Responsive.widgetScaleFactor * 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "I would like to share my location",
                style: Style.textStyle3.copyWith(color: Colors.black54),
              ),
              Switch(value: true, onChanged: (value) {})
            ],
          ),
          SizedBox(height: Responsive.widgetScaleFactor * 4),
          SizedBox(height: Responsive.widgetScaleFactor * 4),
          CustomAddAmountBtn(formState: _formKey.currentState),
        ],
      ),
    );
  }

  String _amountValidator(String value) {
    final isOnlyNumbers = value.contains(RegExp(r"^\d+$"));
    if (!isOnlyNumbers && value.isNotEmpty)
      return "Enter only digits";
    else if (value.isEmpty) return "Amount required";
    return null;
  }

  String _titleValidator(value) {
    print("values");
    print(value.length);
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
