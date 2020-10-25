import 'package:flutter/material.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';

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
                height: 150,
                decoration: _buildBoxDecoration(),
                child: Text(
                  "Add your amount, you have spent",
                  textAlign: TextAlign.center,
                  style: textTheme.headline5
                      .copyWith(fontSize: 22, color: kPureWhite),
                ),
              ),
              Container(
                height: 200,
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
                          style: TextStyle(color: Colors.black),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "Enter a title",
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          textAlignVertical: TextAlignVertical.center,
                          keyboardAppearance: Brightness.dark,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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
