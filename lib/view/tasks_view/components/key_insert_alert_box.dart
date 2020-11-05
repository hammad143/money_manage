import 'package:flutter/material.dart';
import 'package:money_management/util/constants/style.dart';

class KeyInsertAlterBox extends StatefulWidget {
  @override
  _KeyInsertAlterBoxState createState() => _KeyInsertAlterBoxState();
}

class _KeyInsertAlterBoxState extends State<KeyInsertAlterBox> {
  TextEditingController _keyInsertController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("You will be authorized", style:Style.textStyle3),
          SizedBox(height: 10),
          TextField(controller: _keyInsertController,
            decoration: InputDecoration(
            hintText: "Insert a key",
              border: OutlineInputBorder(),
          ),),
        ],
      ),
    );
  }
}
