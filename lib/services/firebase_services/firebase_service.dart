import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference getCollectionIfExists(String collectionName) {
    final collection = FirebaseFirestore.instance.collection(collectionName);
    return collection;
  }

  Future<DocumentReference> addUser(
      {String collectionName, Map<String, dynamic> data}) async {
    final isDocumentExists = await findDocumentExistsByField(
      collectionName: "users",
      dataToMatch: {"id": 0},
      key1: "id",
      key2: "userID",
    );
    if (isDocumentExists == null)
      return await getCollectionIfExists(collectionName).add(data);
    else
      return null;
  }

  Future<QueryDocumentSnapshot> findDocumentExistsByField({
    String collectionName,
    Map<String, dynamic> dataToMatch,
    String key1,
    String key2,
  }) async {
    final documentsReference =
        await getCollectionIfExists(collectionName).get();
    final documents = documentsReference.docs;

    try {
      final document = documents.firstWhere((element) {
        final data = element.data();

        return data[key1] == dataToMatch[key2];
      });

      return document;
    } catch (e) {
      print("Error Document doesn't exists");
      return null;
    }
  }

  Future<QueryDocumentSnapshot> findDocumentFromCollectionByField(
      {CollectionReference collectionReference, keyToFind, value}) async {
    final snapshot = await collectionReference.get();
    final documents = snapshot.docs;
    try {
      return documents.firstWhere((element) {
        final data = element.data();
        return data[keyToFind] == value;
      });
    } catch (error) {
      print("${error}");
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot>> fetchDocumentsByCollection(
      {CollectionReference collection}) async {
    final snapshot = await collection.get();
    final documents = snapshot.docs;
    return documents;
  }

  Future<int> getNumberOfDocs(String collectionName) async {
    final querySnapshot = await getCollectionIfExists(collectionName).get();
    return querySnapshot.docs.length;
  }
}
