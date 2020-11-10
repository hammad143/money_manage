import 'package:bloc/bloc.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize_event.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize_state.dart';

class MakeAuthorizeBloc extends Bloc<MakeAuthorizeEvent, MakeAuthorizeState> {
  MakeAuthorizeBloc() : super(MakeAuthorizeInitState());

  @override
  Stream<MakeAuthorizeState> mapEventToState(MakeAuthorizeEvent event) async* {
    final authorizeKey = event.authorizedKey;
    final letCheck = await FirebaseService().doesKeyMatch(authorizeKey);
    print("check the key $letCheck");
  }
}
