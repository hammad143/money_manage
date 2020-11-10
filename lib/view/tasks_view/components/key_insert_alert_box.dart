import 'package:flutter/material.dart';
import 'package:money_management/util/constants/style.dart';

class KeyInsertAlterBox extends StatefulWidget {
  final TextEditingController keyTextController;

  const KeyInsertAlterBox({Key key, this.keyTextController}) : super(key: key);
  @override
  _KeyInsertAlterBoxState createState() => _KeyInsertAlterBoxState();
}

class _KeyInsertAlterBoxState extends State<KeyInsertAlterBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("You will be authorized", style: Style.textStyle3),
          SizedBox(height: 10),
          TextField(
            controller: widget.keyTextController,
            style: Style.textStyle4,
            decoration: InputDecoration(
              hintText: "Insert a key",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
