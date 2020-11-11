import 'package:equatable/equatable.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';

class CurdFireBaseEvent extends Equatable {
  final GoogleUserModel googleUser;

  CurdFireBaseEvent(this.googleUser);
  @override
  List<Object> get props => [];
}
