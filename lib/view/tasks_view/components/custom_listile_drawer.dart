
import 'package:flutter/material.dart';

class CustomListTileDrawer extends StatelessWidget {
  const CustomListTileDrawer({
    Key key,
    this.onTap,
    @required this.icon,
    @required this.title,
    this.textStyle,
  }) : super(key: key);
  final VoidCallback onTap;
  final String title;
  final Icon icon;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
          onTap: this.onTap,
          title: Row(

            children: [
              icon,
              SizedBox(width: 10),
              Text("$title", style: textStyle),
            ],
          )),
    );
  }
}
