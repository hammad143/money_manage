import 'package:hive/hive.dart';
import 'package:money_management/util/boxes/box.dart';

class BoxesFacade {
  String _localAuthKey,
      _isUserAuthorizedKey,
      _userKey,
      _userUniqueKey,
      _userDisplayNameKey,
      _randomGenerateKey,
      _itemListItemKey,
      _selectedCurrencyKey,
      _allCurrenciesKey;

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

  Box<T> getCurrencyBox<T>() {
    final Boxes<T> box = SelectedCurrencyBox<T>();
    _allCurrenciesKey = box.valueKey;
    return box.getBox();
  }

  Box<T> getAllCurrenciesBox<T>() {
    final Boxes<T> box = CurrencyStoreBox<T>();
    _selectedCurrencyKey = box.valueKey;
    return box.getBox();
  }

  String get localAuthenticationKey => _localAuthKey;
  String get isUserAuthorizedKey => _isUserAuthorizedKey;
  String get userKey => _userKey;
  String get userUniqueKey => _userUniqueKey;
  String get userDisplayNameKey => _userDisplayNameKey;
  String get randomGenerateKey => _randomGenerateKey;
  String get itemListItemKey => _itemListItemKey;
  String get selectedCurrencyKey => _selectedCurrencyKey;
  String get allCurrenciesKey => _allCurrenciesKey;
}
