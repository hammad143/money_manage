import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/util/unique_key.dart';
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
  final _key = GlobalKey<ScaffoldState>();

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

  Widget itemBuilder(AddAmountInfoState state) {
    tileViewModel = state.box.values.cast<ListOfTilesModel>().toList();

    return ListView.builder(
        itemCount: tileViewModel.length,
        itemBuilder: (_, index) {
          this.index = (tileViewModel.length - 1) - index;
          return CustomDismissibleTile(
              tileViewModel: tileViewModel, index: index);
        });
  }

  void _makeAuthorizePopup() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        actions: [
          FlatButton(
            child: Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
          FlatButton(
            child: Text("Authorize"),
            onPressed: () {},
          ),
        ],
        content: KeyInsertAlterBox(),
      ),
    );
  }

  void _keyGeneratePopup() {
    showDialog(
        context: context,
        builder: (ctx) {
          return CustomKeyAlertBox();
          ;
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
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Profile",
                      style: Style.textStyle1.copyWith(
                          fontSize: Responsive.textScaleFactor * 6,
                          fontWeight: FontWeight.w600)),
                  Text("Get the list of people you are authorized by",
                      textAlign: TextAlign.center,
                      style: Style.textStyle1.copyWith(color: Colors.white70)),
                  CustomListTileDrawer(
                    onTap: _keyGeneratePopup,
                    icon: Icon(Icons.vpn_key_outlined, color: Colors.white),
                    title: "Generate Key",
                    textStyle: Style.textStyle1,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: Style.linearGradient,
              ),
              curve: Curves.bounceOut,
            ),
            CustomListTileDrawer(
                onTap: _makeAuthorizePopup,
                icon: Icon(Icons.edit),
                title: "Make Authorize"),
            CustomListTileDrawer(
                onTap: () {},
                icon: Icon(Icons.verified_user),
                title: "Authorized By"),
            CustomListTileDrawer(
                onTap: () {},
                icon: Icon(Icons.person_search),
                title: "Your Authorized"),
            CustomListTileDrawer(
                onTap: () {}, icon: Icon(Icons.settings), title: "Settings"),
            CustomListTileDrawer(
                onTap: () {}, icon: Icon(Icons.close), title: "Quit"),
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
    if (keyBox.get("unique key") == null) {
      keyBox.put("unique key", StoreUniqueKey().uniqueID);
      uniqueID = keyBox.get("unique key");
    } else
      uniqueID = keyBox.get("unique key");
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

  Future<String> uniqueIdGenerate() {}
}

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
