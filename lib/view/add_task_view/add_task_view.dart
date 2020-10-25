import 'package:flutter/material.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/responsive_setup_view.dart';

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
