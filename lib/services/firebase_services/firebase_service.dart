import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/unique_key.dart';

class FirebaseService {
  final collection = FirebaseFirestore.instance.collection("users");

  Future<DocumentReference> addUser(
      {GoogleUserModel googleUserModel, int num}) async {
    DocumentReference docRef;
    if (await isUserExists(googleUserModel) == null) {
      docRef = await collection.add({
        "id": googleUserModel.id.toString(),
        "displayName": googleUserModel.displayName,
        "email": googleUserModel.email,
        "photo_url": googleUserModel.photoUrl,
        "appKey": googleUserModel.appUserKey,
        'auto_id': num,
      });

      return docRef;
    } else
      return null;
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

  Future<bool> get isUserLoggedIn async {
    final GoogleSignIn googleSignIn = await GoogleSignIn();

    final bool isLoggedIn = await googleSignIn.isSignedIn();
    return isLoggedIn ? true : false;
  }

  Future<GoogleUserModel> doesUserExists(GoogleUserModel model) async {
    final collection = FirebaseFirestore.instance.collection("users");
    final getDocs = await collection.get();
    final docs = getDocs.docs;
    print(docs.length);
    GoogleUserModel userModel;
    QueryDocumentSnapshot snapshot;
    try {
      snapshot = docs.firstWhere((element) {
        final data = element.data();

        return data['id'] == model.id.toString() ||
            data['appKey'] == model.appUserKey;
      });
    } catch (error) {
      print("Error Caught ${error}");
    }
    if (snapshot != null) {
      final data = snapshot.data();
      print("This is Snapshot");
      userModel = GoogleUserModel.fromJson(data);
      return userModel;
    } else
      return null;
  }

  createCollection(String collectionName) {
    FirebaseFirestore.instance.collection("users items");
  }

  Future<QuerySnapshot> get eachCollectionDoc => collection.get();
}
