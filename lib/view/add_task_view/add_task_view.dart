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
      body: Center(
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                decoration: const BoxDecoration(
                  color: const Color(0xfff5f5f5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff787878),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: Style.textStyle1
                                .copyWith(color: Colors.black87),
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
                            style: Style.textStyle1
                                .copyWith(color: Colors.black87),
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
                                BlocBuilder<DateTimePickBloc,
                                    DateTimePickState>(builder: (ctx, state) {
                                  String timeToString = "mason";
                                  print("state");
                                  if (state is DateTimePickInitialState) {
                                    final year = state.date.year,
                                        month = state.date.month,
                                        day = state.date.day;
                                    final hour = state.date.hour,
                                        mintues = state.date.minute;
                                    timeToString =
                                        "$month/$day/$year - $hour:$mintues";
                                  } else if (state is DateTimePickedState) {
                                    final year = state.dateTime.year,
                                        month = state.dateTime.month,
                                        day = state.dateTime.day;
                                    final hour = state.dateTime.hour,
                                        mintues = state.dateTime.minute;
                                    timeToString =
                                        "$month/$day/$year - $hour:$mintues";
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
                                      final todayDate = DateTime.now();
                                      final currentTime = TimeOfDay.now();
                                      final timeAndDate =
                                          await showDateAndTimePicker(context);
                                      final datePicker =
                                          timeAndDate[0] as DateTime;
                                      final timePicker =
                                          timeAndDate[1] as TimeOfDay;

                                      final currentTimeWithDate = DateTime(
                                          todayDate.year,
                                          todayDate.month,
                                          todayDate.day,
                                          currentTime.hour,
                                          currentTime.minute);
                                      DateTime settedTime = currentTimeWithDate;
                                      final isTimeSet =
                                          currentTime == timePicker;

                                      if (datePicker == null) {
                                        if (timePicker != null) {
                                          print(
                                              "${timePicker.hour} and ${timePicker.minute}");
                                          final d = DateTime(
                                              todayDate.year,
                                              todayDate.month,
                                              todayDate.day,
                                              timePicker.hour,
                                              timePicker.minute);
                                          BlocProvider.of<DateTimePickBloc>(
                                                  context)
                                              .add(DateTimePickEvent(d));
                                        } else {
                                          BlocProvider.of<DateTimePickBloc>(
                                                  context)
                                              .add(DateTimePickEvent(
                                                  settedTime));
                                        }
                                      } else if (timePicker == null) {
                                        settedTime = DateTime(
                                            datePicker.year,
                                            datePicker.month,
                                            datePicker.day,
                                            currentTime.hour,
                                            currentTime.minute);
                                        BlocProvider.of<DateTimePickBloc>(
                                                context)
                                            .add(DateTimePickEvent(settedTime));
                                      } else {
                                        settedTime = DateTime(
                                            datePicker.year,
                                            datePicker.month,
                                            datePicker.day,
                                            timePicker.hour,
                                            timePicker.minute);
                                        BlocProvider.of<DateTimePickBloc>(
                                                context)
                                            .add(DateTimePickEvent(settedTime));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Responsive.widgetScaleFactor * 4),
                          DropdownButton(
                            isExpanded: true,
                            isDense: false,
                            style: Style.textStyle3,
                            hint: Text("Amount Received/Spent"),
                            onChanged: (value) {},
                            onTap: () {},
                            items: [
                              DropdownMenuItem(
                                value: "Spent",
                                child: Text("Spent"),
                                onTap: () {},
                              ),
                              DropdownMenuItem(
                                value: "Received",
                                child: Text("Received"),
                                onTap: () {},
                              ),
                              DropdownMenuItem(
                                value: "lost",
                                child: Text("Lost"),
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.widgetScaleFactor * 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "I would like to share my location",
                                style: Style.textStyle3
                                    .copyWith(color: Colors.black54),
                              ),
                              Switch(value: true, onChanged: (value) {})
                            ],
                          ),
                          SizedBox(height: Responsive.widgetScaleFactor * 4),
                          Container(
                            height: Responsive.widgetScaleFactor * 17,
                            width: Responsive.widgetScaleFactor * 60,
                            decoration: _buildBoxDecoration().copyWith(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: RaisedButton(
                              color: Colors.transparent,
                              elevation: 0,
                              focusElevation: 0,
                              highlightElevation: 0,
                              onPressed: () {},
                              child: Text(
                                "Add Amount",
                                style: Style.textStyle1.copyWith(
                                    fontSize:
                                        Responsive.widgetScaleFactor * 5.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
