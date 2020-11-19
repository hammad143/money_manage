import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/authorized_view/authorized_view.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/view/tasks_view/components/custom_key_alert.dart';
import 'package:money_management/view/tasks_view/components/custom_listile_drawer.dart';
import 'package:money_management/view/tasks_view/components/key_insert_alert_box.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_bloc.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_bloc.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_event.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_bloc.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_event.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  MakeAuthorizeBloc makeAuthorbloc;
  final _keyTextController = TextEditingController();
  final userDisplayNameBox = Hive.box(kUserDisplayname);
  @override
  Widget build(BuildContext context) {
    makeAuthorbloc = BlocProvider.of<MakeAuthorizeBloc>(context);
    return Container(
      width: Responsive.widgetScaleFactor * 70,
      height: Responsive.deviceHeight,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(top: Responsive.windowTopPadding * 2),
              height: Responsive.deviceBlockHeight * 20,
              decoration: BoxDecoration(
                gradient: Style.linearGradient,
              ),
              child: Column(
                children: [
                  Text("Hi! ${userDisplayNameBox.get("displayName")}",
                      style: Style.textStyle1.copyWith(
                          fontSize: Responsive.textScaleFactor * 6,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: Responsive.widgetScaleFactor * 5),
                  Text("Get yourself notified about authorized users",
                      textAlign: TextAlign.center,
                      style: Style.textStyle1.copyWith(color: Colors.white70)),
                ],
              ),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => _keyGeneratePopup(),
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 1.2,
                        horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      gradient: Style.linearGradient,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.vpn_key_outlined, color: Colors.white),
                        SizedBox(width: 8),
                        Text("Generate Key", style: Style.textStyle1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomListTileDrawer(
                onTap: _makeAuthorizePopup,
                icon: Icon(Icons.edit),
                title: "Make Authorize"),
            /*CustomListTileDrawer(
                onTap: () {},
                icon: Icon(Icons.verified_user),
                title: "Authorized By"),*/
            BlocListener<MakeAuthorizeBloc, MakeAuthorizeState>(
              listener: (ctx, state) async {
                print("I'm the listener");
                if (state is MakeAuthorizeSuccessState) {
                  /*  final x = await state.snapshot.firstWhere((element) {
                        final index = element.docs.length-1;
                        final documentFound =  element.docs.firstWhere((element) => element.data()['auto_increment'] == index);
                        return documentFound != null ? true : false;
                      });*/
                  Navigator.pop(context);
                  final bloc = BlocProvider.of<AuthorizedUsersBloc>(context);
                  final notifierBloc =
                      BlocProvider.of<NotifierItemAddedBloc>(context);
                  bloc.add(AuthorizedUsersEvent(_keyTextController.text));
                  notifierBloc
                      .add(NotifierItemAddedEvent(_keyTextController.text));
                }
              },
              child: CustomListTileDrawer(
                  onTap: () {
                    final route =
                        MaterialPageRoute(builder: (ctx) => AuthorizedView());
                    Navigator.push(context, route);
                  },
                  icon: Icon(Icons.person_search),
                  title: "Your Authorized"),
            ),
            /*CustomListTileDrawer(
                onTap: () {}, icon: Icon(Icons.person_search), title: "Hide"),*/
            CustomListTileDrawer(
                onTap: () async {
                  final _authUserBloc = context.bloc<AuthenticateUserBloc>();
                  _authUserBloc.add(AuthenticateUserSignOuttEvent());
                  /*final route =
                          MaterialPageRoute(builder: (ctx) => SyncView());
                      Navigator.push(context, route);*/
                  //setState(() {});
                },
                icon: Icon(Icons.login),
                title: "Sign Out"),
            CustomListTileDrawer(
                onTap: () async {
                  await SystemNavigator.pop(animated: true);
                },
                icon: Icon(Icons.close),
                title: "Quit"),
          ],
        ),
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

  void _makeAuthorizePopup() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        actions: [
          FlatButton(
            child: Text("Close"),
            onPressed: () => Navigator.pop(ctx),
          ),
          FlatButton(
            child: Text("Authorize"),
            onPressed: () async {
              final authorizedUserKeyBox = Hive.box(kauthorizedUserKey);
              final notifierBloc = BlocProvider.of<NotifierItemAddedBloc>(ctx);
              authorizedUserKeyBox.put("author_key", _keyTextController.text);
              makeAuthorbloc.add(MakeAuthorizeEvent(_keyTextController.text));
              notifierBloc.add(NotifierItemAddedEvent(_keyTextController.text));
            },
          ),
        ],
        content: KeyInsertAlterBox(
          keyTextController: _keyTextController,
        ),
      ),
    );
  }
}
