import 'package:hive/hive.dart';
import 'package:money_management/util/boxes/box.dart';

class BoxesFacade {
  String _localAuthKey, _isUserAuthorizedKey, _userKey;

  Box<T> getLocalAuthenticationBox<T>() {
    Boxes<T> localAuthenticationCheckBox = AuthenticateUserBox<T>();
    _localAuthKey = localAuthenticationCheckBox.key;

    return localAuthenticationCheckBox.getBox();
  }

  Box<T> getIsUserAuthorized<T>() {
    Boxes<T> isUserAuthorizedBox = IsUserAuthorizedBox<T>();
    _isUserAuthorizedKey = isUserAuthorizedBox.key;
    return isUserAuthorizedBox.getBox();
  }

  Box<T> getUserAuthorizedKeyBox<T>() {
    Boxes<T> userAuthorizedKeyBox = UserAuthorizedKeyBox<T>();
    _userKey = userAuthorizedKeyBox.key;
    return userAuthorizedKeyBox.getBox();
  }

  get localAuthenticationKey => _localAuthKey;
  get isUserAuthorizedKey => _isUserAuthorizedKey;
  get userKey => _userKey;
}
