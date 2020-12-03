import 'package:money_management/util/boxes/box.dart';

class BoxesFacade {
  String _localAuthKey, _isUserAuthorizedKey, _userKey;

  Boxes<T> getLocalAuthenticationBox<T>() {
    Boxes<T> localAuthenticationCheckBox = AuthenticateUserBox<T>();
    _localAuthKey = localAuthenticationCheckBox.key;

    return localAuthenticationCheckBox;
  }

  Boxes<T> getIsUserAuthorized<T>() {
    Boxes<T> isUserAuthorizedBox = IsUserAuthorizedBox<T>();
    _isUserAuthorizedKey = isUserAuthorizedBox.key;
    return isUserAuthorizedBox;
  }

  Boxes<T> getUserAuthorizedKeyBox<T>() {
    Boxes<T> userAuthorizedKeyBox = UserAuthorizedKeyBox<T>();
    _userKey = userAuthorizedKeyBox.key;
    return userAuthorizedKeyBox;
  }

  get localAuthenticationKey => _localAuthKey;
  get isUserAuthorizedKey => _isUserAuthorizedKey;
  get userKey => _userKey;
}
