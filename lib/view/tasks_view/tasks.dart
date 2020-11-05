import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/add_task_view/add_task_view.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/view/tasks_view/components/custom_listile_drawer.dart';
import 'package:money_management/view/tasks_view/components/dismissile_cont.dart';
import 'package:money_management/view/tasks_view/components/key_insert_alert_box.dart';
import 'package:money_management/view/tasks_view/components/remain_amount_cont.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _scrollController = ScrollController();
  int index = 0;
  List<ListOfTilesModel> tileViewModel;

  void _navigateToAddTask(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (_) {
        return AddTaskView();
      }),
    );
  }

  Widget _buildDismissible({AddAmountInfoState state}) {
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

  Widget itemBuilder(AddAmountInfoState state) {
    tileViewModel = state.box.values.cast<ListOfTilesModel>().toList();

    return ListView.builder(
        itemCount: tileViewModel.length,
        itemBuilder: (_, index) {
          this.index = (tileViewModel.length - 1) - index;
          return _buildDismissible(state: state);
        });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff5e10c4),
        onPressed: () => _navigateToAddTask(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(),
      drawer: Container(
        width: Responsive.widgetScaleFactor * 70,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Your Profile", style: Style.textStyle1.copyWith(fontSize: Responsive.textScaleFactor * 6, fontWeight: FontWeight.w600)),

                Text("Get the list of people you are authorized by", textAlign: TextAlign.center, style:Style.textStyle1.copyWith(
                  color: Colors.white70
                )),
                CustomListTileDrawer(onTap: () {
                  showDialog(context: context, builder:(ctx) => AlertDialog(
                    actions: [
                      FlatButton(child: Text("Close"), onPressed: () {},),
                      FlatButton(child: Text("Authorize"), onPressed: () {},),
                    ],
                    content: KeyInsertAlterBox(),
                  ),);
                }, icon: Icon(Icons.vpn_key_outlined,color: Colors.white), title: "Generate Key", textStyle: Style.textStyle1,),
              ],
            ),
              decoration: BoxDecoration(
                gradient: Style.linearGradient,
              ),
              curve: Curves.bounceOut,),
            CustomListTileDrawer(onTap: () {}, icon: Icon(Icons.edit), title: "Make Authorize"),
            CustomListTileDrawer(onTap: () {}, icon: Icon(Icons.verified_user), title: "Authorized By"),
            CustomListTileDrawer(onTap: () {}, icon: Icon(Icons.person_search), title: "Your Authorized"),
            CustomListTileDrawer(onTap: () {}, icon: Icon(Icons.settings), title: "Settings"),
            CustomListTileDrawer(onTap: () {}, icon: Icon(Icons.close), title: "Quit"),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(

          children: [
            Scrollbar(
              child: BlocBuilder<AddAmountInfoBloc, AddAmountInfoState>(
                  builder: (ctx, state) {
                if (state is AddAmountInfoInitialState) {
                  return (state.box.isEmpty)
                      ? Center(
                          child: Container(
                          child: Text("Nothing found"),
                        ))
                      : itemBuilder(state);
                }
                return itemBuilder(state);
              }),
            ),

             RemainingAmountContainer()

          ],
        ),
      ),

    );
  }
}
