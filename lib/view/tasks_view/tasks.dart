import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/view/add_task_view/add_task_view.dart';
import 'package:money_management/view/component/custom_drawer/custom_drawer.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/view/sync_view.dart';
import 'package:money_management/view/tasks_view/components/custom_dismissible_tile.dart';
import 'package:money_management/view/tasks_view/components/remain_amount_cont.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize.dart';

class TaskView extends StatefulWidget {
  final GoogleSignIn signIn;

  const TaskView({Key key, this.signIn}) : super(key: key);
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _scrollController = ScrollController();
  final _authGoogleUserBox = Hive.box<bool>(kGoogleAuthKey);
  final _googleIDBox = Hive.box(kGoogleUserId);
  final _key = GlobalKey<ScaffoldState>();
  MakeAuthorizeBloc makeAuthorbloc;

  int index = 0;
  List<ListOfTilesModel> tileViewModel;

  @override
  void initState() {
    super.initState();

    print("Make Authorize Bloc ${makeAuthorbloc}");
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    if (_authGoogleUserBox.get("isLoggedIn") == null)
      return SyncView();
    else
      return Scaffold(
        backgroundColor: const Color(0xffededed),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff5e10c4),
          onPressed: () => _navigateToAddTask(context),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(),
        drawer: CustomDrawer(),
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

/*
* step 1: Put another user Key
*  Look into the Firebase data  if Key matches to the InsertedKey
*  Get the last added item from firebase
*
* */
