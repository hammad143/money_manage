import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_bloc.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_event.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_state.dart';
import 'package:money_management/viewmodel/components/list_of_authorized_users.dart';

class AuthorizedView extends StatefulWidget {
  @override
  _AuthorizedViewState createState() => _AuthorizedViewState();
}

class _AuthorizedViewState extends State<AuthorizedView> {
  final authorizedUserKeyBox = Hive.box(kauthorizedUserKey);
  AuthorizedUsersBloc bloc;
  String authorizeUserKey;
  @override
  void initState() {
    super.initState();
    print("Init Authorized");
    authorizeUserKey = authorizedUserKeyBox.get("author_key");
    bloc = BlocProvider.of<AuthorizedUsersBloc>(context);
    bloc.add(AuthorizedUsersEvent(authorizeUserKey));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependancy change Authorized");
  }

  @override
  Widget build(BuildContext context) {
    final listOfAuthorizedUsers = context
        .findAncestorWidgetOfExactType<ListOfAuthorizedUsersWidget>()
        .listOfAuthorizedUsers;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AuthorizedUsersBloc, AuthorizedUsersState>(
          builder: (ctx, state) {
        if (state is AuthorizedUsersSuccessState) {
          final model = GoogleUserModel.fromJson(state.data);
          return ListView.builder(
              itemCount: listOfAuthorizedUsers.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(
                    "${listOfAuthorizedUsers[index]}",
                    style: TextStyle(color: const Color(0xff000000)),
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
