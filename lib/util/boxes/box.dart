import 'package:hive/hive.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';

class Boxes {
  static final Boxes instance = Boxes._();
  Boxes._();
  factory Boxes() => instance;

  Box onBoardBox,
      generateKeyBox,
      autoIncrementBox,
      googleUserIDStoreBox,
      lastAddedItemBox,
      userDisplayNameBox,
      userAuthorizedKeyBox,
      selectCurrencyBox,
      isUserAuthorizedBox;
  Box<ListOfTilesModel> storageBox;
  Box<int> counterKeyBox;
  Box<bool> authenticateUserBox;
  Box<GoogleUserModelAdapter> googleUserModelBox;

  open() async {
    await Hive.openBox(kHiveDataName);
    await Hive.openBox<int>(kGooglerUserCounterKey);
    await Hive.openBox(kNestedIncrementKey);

    onBoardBox = await Hive.openBox(kHiveBoxOnBoard);
    generateKeyBox = await Hive.openBox(kgenerateKey);
    storageBox = await Hive.openBox<ListOfTilesModel>(storageKey);
    counterKeyBox = await Hive.openBox<int>(counterKey);
    authenticateUserBox = await Hive.openBox<bool>(kGoogleAuthKey);
    autoIncrementBox = await Hive.openBox(kAutoIncrementKey);
    googleUserIDStoreBox = await Hive.openBox(kGoogleUserId);
    googleUserModelBox =
        await Hive.openBox<GoogleUserModelAdapter>(kGoogleUserKey);
    lastAddedItemBox = await Hive.openBox(kLastAddedItemOfAuthorizedUserKey);
    userDisplayNameBox = await Hive.openBox(kUserDisplayname);
    userAuthorizedKeyBox = await Hive.openBox(kauthorizedUserKey);
    selectCurrencyBox = await Hive.openBox(kSelectedCurrency);
    isUserAuthorizedBox = await Hive.openBox(kIsUserAuthroizedKey);
  }
}
