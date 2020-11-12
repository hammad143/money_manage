import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/tasks_view/tasks.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_bloc.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_bloc.dart';
import 'package:money_management/viewmodel/bloc/curd_bloc/curd_bloc.dart';

class SyncView extends StatefulWidget {
  final GoogleSignIn signIn;

  const SyncView({Key key, this.signIn}) : super(key: key);
  @override
  _SyncViewState createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  //AuthenticateUserBloc _authUserbloc;
  final _authGoogleUserBox = Hive.box<bool>(kGoogleAuthKey);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _authUserbloc = BlocProvider.of<AuthenticateUserBloc>(context);
    final curdFirebase = BlocProvider.of<CurdFireBaseBloc>(context);
    print("Call  ${_authGoogleUserBox.get("isLoggedIn")}");
    return BlocBuilder<AuthenticateUserBloc, AuthenticateUserState>(
        builder: (ctx, state) {
      if (state is UserLoggedInState) {
        return TaskView();
      } else {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: Style.linearGradient,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: const Color(0xfff25454),
                    onPressed: () {
                      _authUserbloc.add(AuthenticateUserRequestEvent());
                    },
                    child: Text("Synchronize with Google",
                        style: Style.textStyle1),
                  ),
                  RaisedButton(
                    color: const Color(0xfff25454),
                    onPressed: () async {
                      await GoogleSignIn().signOut();
                    },
                    child: Text("Goto Tasks", style: Style.textStyle1),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
