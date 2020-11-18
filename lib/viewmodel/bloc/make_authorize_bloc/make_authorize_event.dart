import 'package:equatable/equatable.dart';

class MakeAuthorizeEvent extends Equatable {
  final String authorizedKey;

  MakeAuthorizeEvent(this.authorizedKey);
  @override
  List<Object> get props => [authorizedKey];
}
