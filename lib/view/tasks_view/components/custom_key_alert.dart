
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/responsive_setup_view.dart';

class CustomKeyAlertBox extends StatefulWidget {
  @override
  _CustomKeyAlertBoxState createState() => _CustomKeyAlertBoxState();
}

class _CustomKeyAlertBoxState extends State<CustomKeyAlertBox> {
  final keyBox = Hive.box(kgenerateKey);
  String uniqueID;

  @override
  void initState() {
    super.initState();
    uniqueID = keyBox.get("appKey", defaultValue: "null");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(bottom: kDefaultPadding / 1.5),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              minWidth: Responsive.widgetScaleFactor * 13,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => Navigator.pop(context),
              child: Icon(Icons.close),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: FlatButton(
                  padding: EdgeInsets.all(5),
                  onLongPress: () async {
                    await Clipboard.setData(ClipboardData(text: uniqueID));
                  },
                  child: Text(uniqueID, style: Style.textStyle3))),
          Text("Key is Generated", style: Style.textStyle5),
        ],
      ),
    );
  }
}
