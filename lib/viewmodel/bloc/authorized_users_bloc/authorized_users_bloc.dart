import 'package:bloc/bloc.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_event.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_state.dart';

class AuthorizedUsersBloc
    extends Bloc<AuthorizedUsersEvent, AuthorizedUsersState> {
  AuthorizedUsersBloc({AuthorizedUsersInitState initialState})
      : super(AuthorizedUsersInitState());

  final firebaseService = FirebaseService();
  @override
  Stream<AuthorizedUsersState> mapEventToState(
      AuthorizedUsersEvent event) async* {
    final key = event.authorizeUserKey;
    final document = await firebaseService.findDocumentExistsByField(
        collectionName: "users",
        dataToMatch: {"appKey": key},
        key1: "appKey",
        key2: "appKey");
    if (document != null)
      final data = Stream.value(document.data());
    else
      print("Nothing found");
  }
}
