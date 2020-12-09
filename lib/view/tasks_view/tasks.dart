//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/model/tiles_item_model/item_model.dart';
import 'package:money_management/util/boxes_facade/boxes_facade.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/add_task_view/add_task_view.dart';
import 'package:money_management/view/component/custom_appbar/custom_appbar_gradient.dart';
import 'package:money_management/view/component/custom_drawer/custom_drawer.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/view/sync_view.dart';
import 'package:money_management/view/total_sum_view.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_bloc.dart';

class TaskView extends StatefulWidget {
  final GoogleSignIn signIn;

  const TaskView({Key key, this.signIn}) : super(key: key);
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final listScrollController = ScrollController();
  //final _authGoogleUserBox = Hive.box<bool>(kGoogleAuthKey);
  final _googleIDBox = Hive.box(kGoogleUserId);
  final _key = GlobalKey<ScaffoldState>();
  final boxesFacade = BoxesFacade();
  //final isUserAuthroizedBox = Hive.box(kIsUserAuthroizedKey);
  //final authorizedUserKeyBox = Hive.box(kauthorizedUserKey);
  NotifierItemAddedBloc notifierBloc;
  MakeAuthorizeBloc makeAuthorbloc;
  int index = 0;
  List<ListOfTilesModel> tileViewModel;
  Box<ItemsAddingModel> itemAddingBox;
  @override
  void initState() {
    super.initState();
    notifierBloc = BlocProvider.of<NotifierItemAddedBloc>(context);
    BlocProvider.of<AddAmountInfoBloc>(context)
        .add(AddAmountInfoInitialEvent());

    final bool isUserLoggedIn = boxesFacade
        .getIsUserAuthorized()
        .get(boxesFacade.isUserAuthorizedKey, defaultValue: false);
    itemAddingBox = boxesFacade.getListItemBox<ItemsAddingModel>();
  }

  @override
  void dispose() {
    listScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToAddTask(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (_) {
        return AddTaskView();
      }),
    );
  }

  Widget itemBuilder(List<ItemsAddingModel> items) {
    return ListView.builder(
        controller: listScrollController,
        physics: BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (_, index) {
          return Center(
            child: Text("${items[index].title}, ${items[index].amount}"),
          );
          //return CustomDismissibleTile(tileViewModel: data, index: index);
        });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    if (boxesFacade
            .getLocalAuthenticationBox<bool>()
            .get(boxesFacade.localAuthenticationKey) ==
        null)
      return SyncView();
    else
      return Scaffold(
        key: _drawerKey,
        backgroundColor: const Color(0xffededed),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff5e10c4),
          onPressed: () => _navigateToAddTask(context),
          child: const Icon(Icons.add),
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            CustomAppBarGradient(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.transparency,
                      child: IconButton(
                          iconSize: Responsive.widgetScaleFactor * 8,
                          icon: Icon(Icons.dashboard, color: Colors.white),
                          onPressed: () =>
                              _drawerKey.currentState.openDrawer()),
                    ),
                  ),
                  Expanded(
                      child: Center(
                          child: Text("Added Items", style: Style.textStyle6))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.transparency,
                      child: IconButton(
                          iconSize: Responsive.widgetScaleFactor * 8,
                          icon: Icon(Icons.attach_money_outlined,
                              color: Colors.white),
                          onPressed: () async {
                            //Add Somethign here
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => TotalSumView()));
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Scrollbar(
                    child: BlocBuilder<AddAmountInfoBloc, AddAmountInfoState>(
                        builder: (ctx, state) {
                      if (state is AddAmountInfoError)
                        return Center(child: CircularProgressIndicator());
                      else
                        return Center(child: itemBuilder(state.model)
                            //return CircularProgressIndicator();
                            );
                    }),
                  ),
                  RaisedButton(
                      onPressed: () {
                        BlocProvider.of<AddAmountInfoBloc>(context).add(
                            AddAmountInfoEvent("Malik Riaz", "200",
                                "20/10/2021/", null, "3.55", null));
                      },
                      child: Text("Click")),
                  //RemainingAmountContainer()
                ],
              ),
            ),
          ],
        ),
      );
  }
}

/*
* step 1: Put another user Key
*  Look into the Firebase data  if Key matches to the InsertedKey
*  Get the last added item from firebase
*
* */
