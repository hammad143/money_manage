import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/style.dart';

class DismissibleCustomContainer extends StatelessWidget {
  final List<ListOfTilesModel> tilesList;
  final int index;
  const DismissibleCustomContainer({Key key, this.tilesList, this.index})
      : super(key: key);
  @override
  build(_) {
    final textTheme = Theme.of(_).textTheme;
    return Container(
      decoration: _buildBoxDecoration(),
      margin: EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      child: _buildListTile(textTheme),
    );
  }

  ListTile _buildListTile(TextTheme textTheme) {
    final List<String> times = tilesList[index].dateInString.split(RegExp("-"));
    return ListTile(
      title: Text(tilesList[index].title, style: Style.textStyle1),
      subtitle: Text("Date: ${times[0]}", style: Style.textStyle2),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(tilesList[index].amount, style: Style.textStyle1),
          Text("Option: ${tilesList[index].option}, Time: ${times[1]} ",
              style: Style.textStyle2),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      gradient: Style.linearGradient,
      borderRadius: BorderRadius.circular(5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xffa6a6a6),
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}
