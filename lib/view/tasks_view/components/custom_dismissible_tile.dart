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
      child: Dismissible(
        confirmDismiss: (dismissDir) {
          print("Confirm Dissmiss");
          return Future.value(true);
        },
        onDismissed: (dissmiss) {
          print("On Dissmissed");
        },
        background: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.restore_from_trash_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.restore_from_trash_rounded),
            ),
          ],
        ),
        key: UniqueKey(),
        child: Stack(
          children: [
            DismissibleCustomContainer(
              tilesList: tileViewModel,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}
