import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/constants/style.dart';
import 'package:money_management/view/component/custom_appbar/custom_appbar_gradient.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_bloc.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_state.dart';

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependancy change Authorized");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarGradient(
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<AuthorizedUsersBloc, AuthorizedUsersState>(
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
                            trailing: Text(
                              "Total Items\n${state.totalItems}",
                              textAlign: TextAlign.center,
                              style: Style.textStyle2,
                            ),
                          ),
                        ),
                      );
                    });
              } else
                return Center(
                  child: Text("You've not authorized anyone"),
                );
            }),
          ),
        ],
      ),
    );
  }
}
