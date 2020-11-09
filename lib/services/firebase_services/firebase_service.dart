import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';

class FirebaseService {
  final collection = FirebaseFirestore.instance.collection("users");

  Future<bool> addUser({GoogleUserModel googleUserModel}) async {
    await collection
        .add({"id": googleUserModel.id, "name": googleUserModel.displayName});
    return true;
  }

  isUserExists(GoogleUserModel googleUserModel) async {
    final docsRef = await collection.get();
    final docs = docsRef.docs;
    print(docs.length);
    final snapshot = docs.firstWhere((element) {
      final data = element.data();
      return data['id'] == googleUserModel.id.toString()
      0;
    });
    print(snapshot.exists);
  }
}
