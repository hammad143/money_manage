import 'package:flutter/material.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/view/tasks_view/components/dismissile_cont.dart';

class CustomDismissibleTile extends StatelessWidget {
  const CustomDismissibleTile({
    Key key,
    @required this.tileViewModel,
    @required this.index,
  }) : super(key: key);

  final List<ListOfTilesModel> tileViewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          DismissibleCustomContainer(
            tilesList: tileViewModel,
            index: index,
          ),
        ],
      ),
    );
  }
}
