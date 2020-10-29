import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/add_task_view/add_task_view.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';

class TaskView extends StatelessWidget {
  final _scrollController = ScrollController();

  _navigateToAddTask(BuildContext ctx) {
    //Navigator.pop(ctx);
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (_) {
        return AddTaskView();
      }),
    );
  }

  Widget _buildDismissible({AddAmountInfoState state}) {
    print("${state.runtimeType} ");
    if (state is AddAmountInfoDone) {
      print("Initial State ${state.hiveBox.get("title")}");
    }
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
            DismissibleCustomContainer(),
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
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (_, index) {
                  return BlocBuilder<AddAmountInfoBloc, AddAmountInfoState>(
                      builder: (ctx, state) => _buildDismissible(state: state));
                },
              ),
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
      title: Text("Title", style: Style.textStyle1),
      subtitle: Text("Oct/20/10", style: Style.textStyle2),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("\$300", style: Style.textStyle1),
          Text("Spent at: 08:00PM", style: Style.textStyle2),
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
