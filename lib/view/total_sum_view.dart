import 'package:flutter/material.dart';
import 'package:money_management/view/component/custom_appbar/custom_appbar_gradient.dart';

class TotalSumView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            CustomAppBarGradient(
              child: Row(
                children: [
                  FlatButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    label: Text("Go Back"),
                  )
                ],
              ),
            ),
            Center(
              child: Text("Centered Text"),
            ),
          ],
        ),
      ),
    );
  }
}
