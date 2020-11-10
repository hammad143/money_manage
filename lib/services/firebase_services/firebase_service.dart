import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/unique_key.dart';

class FirebaseService {
  final collection = FirebaseFirestore.instance.collection("users");

  Future<bool> addUser({GoogleUserModel googleUserModel}) async {
    if (await isUserExists(googleUserModel) == null) {
      await collection.add({
        "id": googleUserModel.id.toString(),
        "displayName": googleUserModel.displayName,
        "email": googleUserModel.email,
        "photo_url": googleUserModel.photoUrl,
        "appKey": googleUserModel.appUserKey,
      });
      print("User Added");
      return true;
    } else
      return false;
  }

  Future<QueryDocumentSnapshot> isUserExists(
      [GoogleUserModel googleUserModel]) async {
    final docsRef = await collection.get();
    QueryDocumentSnapshot singleDocument = null;
    final docs = docsRef.docs;

    try {
      singleDocument = docs.firstWhere((element) {
        final data = element.data();

        return data['id'] == googleUserModel.id.toString();
      });
      print("User Exists $singleDocument");
    } catch (e) {
      print("Error ${e}");
      singleDocument = null;
    }
    return singleDocument;
  }

  Future<bool> doesKeyMatch(String authorizeKey) async {
    bool isExists = false;

    final box = Hive.box(kgenerateKey);
    StoreUniqueKey.set(box.get("unqiue key"));
    final collection = FirebaseService().collection;
    final docsOfCollection = await collection.get();
    final docs = docsOfCollection.docs;
    try {
      docs.firstWhere((element) {
        final eachDocumentFields = element.data();
        isExists =
            eachDocumentFields['appKey'] == StoreUniqueKey.instance.uniqueID;
        print("Get the KEy ${StoreUniqueKey.instance.uniqueID}");
        return isExists;
      });
    } catch (error) {
      print("Key Doesn't  $isExists don't Make Authorize");
      return isExists;
    }
  }

  /*
  Future<String> fetchUserKey() async{
    final collectionDocs = await eachCollectionDoc;
    final documents = collectionDocs.docs;
    try {
      documents.firstWhere((element) {
      final data = element.data();
      data['id'] ==
      });
    }catch(error) {

    }
  }
  isUserKeyExists() {

  }
*/
  Future<QuerySnapshot> get eachCollectionDoc => collection.get();
}
