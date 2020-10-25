import 'package:flutter/material.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/add_task_view/add_task_view.dart';

class TaskView extends StatelessWidget {
  final _scrollController = ScrollController();

  _navigateToAddTask(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (_) {
        return AddTaskView();
      }),
    );
  }

  Widget _buildDismissible() {
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
                itemCount: 100,
                itemBuilder: (_, index) {
                  return _buildDismissible();
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
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultValue / 2.5),
          topRight: Radius.circular(kDefaultValue / 2.5),
          bottomLeft: Radius.circular(kDefaultValue / 2.5),
          bottomRight: Radius.circular(kDefaultValue / 2.5),
        ),
      ),
      child: const Text("\$300"),
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
      title: Text("Title", style: textTheme.headline6),
      subtitle: Text("Oct/20/10", style: textTheme.subtitle1),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("\$300", style: textTheme.headline6),
          Text("Spent", style: textTheme.subtitle1),
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
