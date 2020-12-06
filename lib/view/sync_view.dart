import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management/services/authenticate_user_service/authenticate_user_service.dart';
import 'package:money_management/util/boxes/box.dart';
import 'package:money_management/util/responsive_and_text_pkg.dart';
import 'package:money_management/view/tasks_view/tasks.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_event.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_state.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_bloc.dart';

class SyncView extends StatefulWidget {
  @override
  _SyncViewState createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddAmountInfoBloc>(context)
        .add(AddAmountInfoInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticateUserBloc, AuthenticateUserState>(
        builder: (ctx, state) {
      if (state is UserLoggedInState) {
        //print("User has been logged in successfully");
        return TaskView();
      } else {
        return Scaffold(
          body: BlocListener<AddAmountInfoBloc, AddAmountInfoState>(
            listener: (ctx, state) {
              print("######### ${state.runtimeType} ############");
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: Style.linearGradient,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Responsive.widgetScaleFactor * 60,
                      child: RaisedButton(
                        color: Colors.white, //const Color(0xfff25454),
                        onPressed: () {
                          BlocProvider.of<AuthenticateUserBloc>(context).add(
                            AuthenticateUserRequestEvent(
                              AuthenticationType.google,
                            ),
                          );
                        },
                        child: Container(
                          height: Responsive.widgetScaleFactor * 8,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/currency/google_icon.png",
                              ),
                              SizedBox(width: 8),
                              Text("Sign in with Google",
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.widgetScaleFactor * 60,
                      child: FittedBox(
                        child: RaisedButton(
                          color: const Color(0xff3b569d),
                          onPressed: () async {
                            BlocProvider.of<AddAmountInfoBloc>(context).add(
                              AddAmountInfoEvent("Aliyah Brian", "200",
                                  "20/20/2020", null, "\$200", null),
                            );
                          },
                          child: Container(
                            height: Responsive.widgetScaleFactor * 8,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/currency/facebook_logo.png",
                                ),
                                SizedBox(width: 8),
                                Text("Sign in with Facebook",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
