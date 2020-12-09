import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';

abstract class Boxes<T> {
  String valueKey;
  String key;
  T type;
  static void open<T>(Boxes<T> box) async {
    await Hive.openBox<T>(box.key);
  }

  Box<T> getBox() => Hive.box<T>(key);
}

class IsUserAuthorizedBox<T> extends Boxes<T> {
  static const String IS_AUTHORRIZED_KEY = "is authorized user";
  @override
  String get valueKey => IS_AUTHORRIZED_KEY;
  @override
  String get key => kIsUserAuthroizedKey;
}

class SelectedCurrencyBox<T> extends Boxes<T> {
  static final CURRENCY_KEY = "selected currency";
  @override
  // TODO: implement valueKey
  String get valueKey => CURRENCY_KEY;
  @override
  String get key => kSelectedCurrency;
}

class UserAuthorizedKeyBox<T> extends Boxes<T> {
  static const String USER_AUTH_KEY = "user authorized";
  @override
  // TODO: implement valueKey
  String get valueKey => USER_AUTH_KEY;
  @override
  String get key => kauthorizedUserKey;
}

class UserDisplayNameBox<T> extends Boxes<T> {
  static const DISPLAY_NAME = "displayName";
  @override
  String get valueKey => DISPLAY_NAME;
  @override
  String get key => kUserDisplayname;
}

class LastAddedItemKeyBox<T> extends Boxes<T> {
  @override
  String get key => kLastAddedItemOfAuthorizedUserKey;
}

class StoreGoogleUserModelBox<T> extends Boxes {
  @override
  String get key => kGoogleUserKey;
}

class AuthenticateUserBox<T> extends Boxes<T> {
  static const IS_USER_LOGGED_IN = "isLoggedIn";
  @override
  String get valueKey => IS_USER_LOGGED_IN;
  @override
  String get key => kGoogleAuthKey;
}

class StoreUserIDBox<T> extends Boxes<T> {
  static const ID = "userID";
  @override
  String get valueKey => ID;
  @override
  String get key => kGoogleUserId;
}

class GenerateRandomKeyBox<T> extends Boxes<T> {
  static const APP_KEY = "appKey";
  @override
  String valueKey = APP_KEY;
  @override
  String get key => kgenerateKey;
}

class StoreListTileModelBox<T> extends Boxes<T> {
  static const ITEM_KEY = "item added key";

  @override
  String get valueKey => ITEM_KEY;
  @override
  String get key => storageKey;
}

class AutoIncrementIDBox<T> extends Boxes<T> {
  static const AUTO_INCREMENT = "auto_increment";
  @override
  String get valueKey => AUTO_INCREMENT;
  @override
  String get key => kAutoIncrementKey;
}
