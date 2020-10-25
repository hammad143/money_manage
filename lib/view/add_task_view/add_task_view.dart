import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_bloc.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_event.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_state.dart';

class AddTaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding,
                ),
                decoration: _buildBoxDecoration(),
                height: Responsive.widgetScaleFactor * 30,
                child: Text(
                  "Add your amount, you have spent",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Responsive.textScaleFactor * 8,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffe0e0e0),
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(kDefaultValue),
                    bottomLeft: Radius.circular(kDefaultValue),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style:
                              Style.textStyle1.copyWith(color: Colors.black87),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: Responsive.textScaleFactor * 4.5),
                            hintText: "Enter a title",
                          ),
                        ),
                        SizedBox(height: Responsive.widgetScaleFactor * 4),
                        TextFormField(
                          style:
                              Style.textStyle1.copyWith(color: Colors.black87),
                          textAlignVertical: TextAlignVertical.center,
                          keyboardAppearance: Brightness.dark,
                          keyboardType: TextInputType.number,
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
                                if (state is DateTimePickInitialState) {
                                  final time = state.date;
                                  timeToString =
                                      "${time.month}/${time.day}/${time.year} - ${time.hour}:${time.minute}";
                                } else if (state is DateTimePickedState) {
                                  final time = state.dateTime;
                                  timeToString =
                                      "${time.month}/${time.day}/${time.year} - ${time.hour}:${time.minute}";
                                }
                                return Text(timeToString,
                                    style: Style.textStyle1
                                        .copyWith(color: Colors.black54));
                              }),
                              Material(
                                shape: CircleBorder(),
                                type: MaterialType.transparency,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.date_range,
                                    color: const Color(0xff6324a3),
                                  ),
                                  onPressed: () async {
                                    final timeAndDate =
                                        await showDateAndTimePicker(context);
                                    final datePicker = timeAndDate[0];
                                    final timePicker = timeAndDate[1];
                                    final todayDate = DateTime.now();
                                    final currentTime = TimeOfDay.now();
                                    final currentTimeWithDate = DateTime(
                                        todayDate.year,
                                        todayDate.month,
                                        todayDate.day,
                                        currentTime.hour,
                                        currentTime.minute);
                                    DateTime settedTime = currentTimeWithDate;
                                    final isTimeSet = currentTime == timePicker;
                                    print(
                                        "Current Time: $currentTime and TimePicker $timePicker");
                                    print(
                                        "DatePicker $datePicker && TimePicker $timePicker");
                                    if (datePicker == null) {
                                      if (isTimeSet == false) {
                                        settedTime = DateTime(
                                            todayDate.year,
                                            todayDate.month,
                                            todayDate.day,
                                            timePicker.hour,
                                            timePicker.minute);
                                        BlocProvider.of<DateTimePickBloc>(
                                                context)
                                            .add(DateTimePickEvent(settedTime));
                                      } else {
                                        print("time");
                                        BlocProvider.of<DateTimePickBloc>(
                                                context)
                                            .add(DateTimePickEvent(settedTime));
                                      }
                                    } else if (isTimeSet) {
                                      print(
                                          "Is this Picker Working When time null");
                                      settedTime = DateTime(
                                          datePicker.year,
                                          datePicker.month,
                                          datePicker.day,
                                          currentTime.hour,
                                          currentTime.minute);
                                      BlocProvider.of<DateTimePickBloc>(context)
                                          .add(DateTimePickEvent(settedTime));
                                    } else {
                                      print("t");
                                      settedTime = DateTime(
                                          datePicker.year,
                                          datePicker.month,
                                          datePicker.day,
                                          timePicker.hour,
                                          timePicker.minute);
                                      BlocProvider.of<DateTimePickBloc>(context)
                                          .add(DateTimePickEvent(settedTime));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.widgetScaleFactor * 4),
                        RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Show Time Picker")),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: const Color(0xffe0e0e0),
          blurRadius: 3,
        ),
      ],
      gradient: Style.linearGradient,
      /*  borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kDefaultValue),
        topRight: Radius.circular(kDefaultValue),
      ),*/
    );
  }
}
