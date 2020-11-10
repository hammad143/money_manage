import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/viewmodel/bloc/curd_bloc/curd_bloc.dart';

class MakeAuthorizeBloc extends Bloc<CurdFireBaseEvent, CurdFireBaseState> {
  MakeAuthorizeBloc() : super(CurdFireBaseInitState());

  @override
  Stream<CurdFireBaseState> mapEventToState(CurdFireBaseEvent event) async* {
    final firebaseService = FirebaseService();

    final QueryDocumentSnapshot doc = await firebaseService.isUserExists();
    if (doc != null) {
      final documentFields = doc.data();

      yield CurdFireBaseSuccessState();
    }
  }

  Future<GoogleUserModel> get isUserLoggedIn async {
    final GoogleSignIn googleSignIn = await GoogleSignIn();

    final bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn)
      return GoogleUserModel();
    else
      return GoogleUserModel();
  }
}
