import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/services/authenticate_user_service/authenticate_user_service.dart';
import 'package:money_management/util/boxes/box.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/tasks_view/tasks.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_bloc.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_bloc.dart';

class SyncView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authUserbloc = BlocProvider.of<AuthenticateUserBloc>(context);

    return BlocBuilder<AuthenticateUserBloc, AuthenticateUserState>(
        builder: (ctx, state) {
      if (state is UserLoggedInState) {
        print("User has been logged in successfully");
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
                      _authUserbloc.add(AuthenticateUserRequestEvent(
                          AuthenticationType.google));
                    },
                    child: Text("Synchronize with Google",
                        style: Style.textStyle1),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  bool isUserLoggedIn() {
    return AuthenticateUserBox<bool>()
        .getBox()
        .get(AuthenticateUserBox.IS_USER_LOGGED_IN, defaultValue: false);
  }
}
