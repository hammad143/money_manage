import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';

class FirebaseService {
  final collection = FirebaseFirestore.instance.collection("users");

  Future<bool> addUser({GoogleUserModel googleUserModel}) async {
    if (!await isUserExists(googleUserModel)) {
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

  Future<bool> isUserExists([GoogleUserModel googleUserModel]) async {
    final docsRef = await collection.get();
    bool doesExists;

    final docs = docsRef.docs;

    try {
      final isExists = docs.firstWhere((element) {
        final data = element.data();

        return data['id'] == googleUserModel.id.toString();
      });
      print("User Exists $isExists");
      doesExists = true;
    } catch (e) {
      print("Error ${e}");
      doesExists = false;
    }
    return doesExists;
  }
}
