import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_bloc.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_event.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: null,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container();
            } else
              return Center(
                child: Text("You've not authorized anyone"),
              );
          }),
    );
  }
}
