import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize_event.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize_state.dart';

class MakeAuthorizeBloc extends Bloc<MakeAuthorizeEvent, MakeAuthorizeState> {
  MakeAuthorizeBloc() : super(MakeAuthorizeInitState());

  @override
  Stream<MakeAuthorizeState> mapEventToState(MakeAuthorizeEvent event) async* {
    final String authorizeKey = event.authorizedKey;
    final keyBox = Hive.box(kgenerateKey);
    final user = await FirebaseService()
        .doesUserExists(GoogleUserModel(appUserKey: authorizeKey));

    if (user != null && user.appUserKey != keyBox.get("unique key")) {}
  }
}
