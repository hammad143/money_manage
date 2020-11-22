import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/add_task_view/components/add_task_form.dart';
import 'package:money_management/view/component/custom_appbar/custom_appbar_gradient.dart';
import 'package:money_management/view/responsive_setup_view.dart';

class AddTaskView extends StatefulWidget {
  @override
  _AddTaskViewState createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final windowPadding = MediaQuery.of(context).padding;
    final textTheme = Theme.of(context).textTheme;
    Responsive.init(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CustomAppBarGradient(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context)),
                  ),
                  Expanded(
                      child: Center(
                          child: Text("Add Your Items Here",
                              style: Style.textStyle6))),
                ],
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
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const AddTaskForm(),
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

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
