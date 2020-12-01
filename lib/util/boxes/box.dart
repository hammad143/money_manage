import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';

abstract class Boxes<T> {
  String key;
  T type;
  static void open<T>(Boxes<T> box) async {
    await Hive.openBox<T>(box.key);
  }

  Box<T> getBox() => Hive.box<T>(key);
}

class IsUserAuthorizedBox<T> extends Boxes<T> {
  @override
  String key = kIsUserAuthroizedKey;
}

class SelectedCurrencyBox<T> extends Boxes<T> {
  @override
  String key = kSelectedCurrency;
}

class UserAuthorizedKeyBox<T> extends Boxes<T> {
  @override
  String key = kauthorizedUserKey;
}

class UserDisplayNameBox<T> extends Boxes<T> {
  static const DISPLAY_NAME = "displayName";
  @override
  String key = kUserDisplayname;
}

class LastAddedItemKeyBox<T> extends Boxes<T> {
  @override
  String key = kLastAddedItemOfAuthorizedUserKey;
}

class StoreGoogleUserModelBox<T> extends Boxes {
  @override
  String key = kGoogleUserKey;
}

class AuthenticateUserBox<T> extends Boxes<T> {
  static const IS_USER_LOGGED_IN = "isLoggedIn";

  @override
  String key = kGoogleAuthKey;
}

class StoreUserIDBox<T> extends Boxes<T> {
  static const ID = "userID";
  @override
  String key = kGoogleUserId;
}

class GenerateRandomKeyBox<T> extends Boxes<T> {
  static const APP_KEY = "appKey";
  @override
  String key = kgenerateKey;
}

class StoreListTileModelBox<T> extends Boxes<T> {
  @override
  String key = storageKey;
}

class AutoIncrementIDBox<T> extends Boxes<T> {
  static const AUTO_INCREMENT = "auto_increment";

  @override
  String key = kAutoIncrementKey;
}
