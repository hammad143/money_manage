import 'package:hive/hive.dart';
import 'package:money_management/util/boxes/box.dart';

class BoxesFacade {
  String _localAuthKey,
      _isUserAuthorizedKey,
      _userKey,
      _userUniqueKey,
      _userDisplayNameKey,
      _randomGenerateKey,
      _itemListItemKey;

  Box<T> getListItemBox<T>() {
    Boxes<T> box = StoreListTileModelBox();
    _itemListItemKey = box.valueKey;
    return box.getBox();
  }

  Box<T> getLocalAuthenticationBox<T>() {
    Boxes<T> localAuthenticationCheckBox = AuthenticateUserBox<T>();
    _localAuthKey = localAuthenticationCheckBox.valueKey;

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

  Box<T> getUserUniqueKeyBox<T>() {
    Boxes<T> box = StoreUserIDBox<T>();
    _userUniqueKey = box.key;
    return box.getBox();
  }

  Box<T> getUserDisplayName<T>() {
    Boxes<T> displayNameBox = UserDisplayNameBox<T>();
    _userDisplayNameKey = displayNameBox.key;
    return displayNameBox.getBox();
  }

  Box<T> getRandomGenerateKeyBox<T>() {
    Boxes<T> box = GenerateRandomKeyBox<T>();
    _randomGenerateKey = box.key;
    return box.getBox();
  }

  get localAuthenticationKey => _localAuthKey;
  get isUserAuthorizedKey => _isUserAuthorizedKey;
  get userKey => _userKey;
  get userUniqueKey => _userUniqueKey;
  get userDisplayNameKey => _userDisplayNameKey;
  get randomGenerateKey => _randomGenerateKey;
  get itemListItemKey => _itemListItemKey;
}
