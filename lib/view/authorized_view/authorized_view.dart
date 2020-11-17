import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_bloc.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_state.dart';

class AuthorizedView extends StatefulWidget {
  @override
  _AuthorizedViewState createState() => _AuthorizedViewState();
}

class _AuthorizedViewState extends State<AuthorizedView> {
  final authorizedUserKeyBox = Hive.box(kauthorizedUserKey);
  final StreamController streamController = StreamController();
  AuthorizedUsersBloc bloc;
  String authorizeUserKey;
  @override
  void initState() {
    super.initState();
    print("Init Authorized");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependancy change Authorized");
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ;

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AuthorizedUsersBloc, AuthorizedUsersState>(
          builder: (ctx, state) {
        if (state is AuthorizedUsersSuccessState) {
          print("Direct State is Success");
          final listOfUsers = state.data;
          return ListView.separated(
              separatorBuilder: (ctx, index) => SizedBox(height: 5),
              itemCount: listOfUsers.length,
              itemBuilder: (ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: Style.linearGradient,
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: ListTile(
                      onTap: () {},
                      title: Text(listOfUsers[index].displayName,
                          style: Style.textStyle1),
                      subtitle: Text(listOfUsers[index].email,
                          style: Style.textStyle2),
                    ),
                  ),
                );
              });
        } else
          return Center(
            child: Text("You've not authorized anyone"),
          );
      }),
    );
  }
}
