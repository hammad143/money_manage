import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_event.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_user_state.dart';

class AuthenticateUserBloc
    extends Bloc<AuthenticateUserEvent, AuthenticateUserState> {
  static final String clientID =
      "7425334217-eckkm2ram44cjnokt0hd7n1tv2e63msc.apps.googleusercontent.com";
  GoogleSignIn googleSignIn = GoogleSignIn();
  final OauthBox = Hive.box<bool>(kGoogleAuthKey);
  AuthenticateUserBloc() : super(UserNotLoggedInState());

  @override
  Stream<AuthenticateUserState> mapEventToState(
      AuthenticateUserEvent event) async* {
    if (event is AuthenticateUserRequestEvent) {
      print("Auth");
      if (OauthBox.get("isLoggedIn") == null) {
        final isLoggedIn = await googleSignIn.signIn();
        print("Google ${isLoggedIn}");
        if (isLoggedIn != null) {
          OauthBox.put("isLoggedIn", true);
          yield UserLoggedInState();
        }
      }
    } //if(event is Authenticate)
    else if (event is AuthenticateUserSignOuttEvent) {
      OauthBox.delete("isLoggedIn");
      final x = await googleSignIn.signOut();
      print("User Signout ${x}");
      yield UserNotLoggedInState();
    }
  } // mapEventToState

}
