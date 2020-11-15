import 'package:flutter/material.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';

class ListOfAuthorizedUsersWidget extends InheritedWidget {
  final List<GoogleUserModel> listOfAuthorizedUsers = [];

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
