import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/add_task_view/add_task_view.dart';
import 'package:money_management/view/responsive_setup_view.dart';
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
  final storageBox = Hive.box<ListOfTilesModel>(storageKey);
  ValueNotifier<Box<ListOfTilesModel>> _notifier;

  @override
  void initState() {
    super.initState();
    //final list = _box.get("storage").cast<ListOfTilesModel>().toList();
    tileViewModel = storageBox.values.toList();
    _notifier = ValueNotifier<Box<ListOfTilesModel>>(storageBox);
  }

  void _navigateToAddTask(BuildContext ctx) {
    //Navigator.pop(ctx);
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

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: const Color(0xffededed),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTask(context),
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Scrollbar(
              //controller: _scrollController,

              child: BlocBuilder<AddAmountInfoBloc, AddAmountInfoState>(
                  builder: (ctx, state) {
                if (state is AddAmountInfoInitialState) {
                  if (state.box.isEmpty) {
                    return Center(
                      child: Container(
                        child: Text("Nothing found"),
                      ),
                    );
                  } else {
                    return itemBuilder(state);
                  }
                }
                return itemBuilder(state);
              }),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(child: RemainingAmountContainer()),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(AddAmountInfoState state) {
    tileViewModel = state.box.values.cast<ListOfTilesModel>().toList();
    print(tileViewModel[1].title);
    return ListView.builder(
        itemCount: tileViewModel.length,
        itemBuilder: (_, index) {
          this.index = index;
          return _buildDismissible(state: state);
        });
  }
}

class RemainingAmountContainer extends StatelessWidget {
  const RemainingAmountContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      //height: Responsive.deviceBlockHeight * 8,
      width: Responsive.deviceBlockWidth * 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        boxShadow: [
          const BoxShadow(
            blurRadius: 2,
            color: Color(0xff7d7d7d),
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultValue / 2.5),
          topRight: Radius.circular(kDefaultValue / 2.5),
          bottomLeft: Radius.circular(kDefaultValue / 2.5),
          bottomRight: Radius.circular(kDefaultValue / 2.5),
        ),
      ),
      child: Text(
        "All over used amount\n\$300",
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 1.5,
          fontWeight: FontWeight.w600,
          fontSize: Responsive.textScaleFactor * 5,
        ),
      ),
    );
  }
}

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
    return ListTile(
      title: Text(tilesList[index].title, style: Style.textStyle1),
      subtitle: Text(tilesList[index].dateInString, style: Style.textStyle2),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(tilesList[index].amount, style: Style.textStyle1),
          Text("${tilesList[index].option} at: 08:00PM",
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
