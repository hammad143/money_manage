import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_management/model/user_adding_decorator/user_adding_decorator.dart';
//import 'package:firebase/firestore.dart';
import 'package:money_management/model/user_adding_model/google_user_adding_model.dart';
import 'package:money_management/model/user_adding_model/user_adding_model.dart';

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

abstract class FBService<T> {
  final CollectionReference userCollection = null;

  T addUser(UserAddingModel model);

  deleteUser();

  T findUser(UserAddingModel model);
  List findUsers<T>();
}

class GoogleFirebaseService implements FBService<Future<DocumentReference>> {
  //QueryFirebase _queryFirebase;

  @override
  CollectionReference get userCollection =>
      FirebaseFirestore.instance.collection("users");

  @override
  Future<DocumentReference> addUser(UserAddingModel model) async {
    final totalUsers = await QueryFirebase(userCollection).totalUsers();
    DocumentReference documentReference = await findUser(model);
    if (documentReference == null) {
      model = UserMapUpdateDecorator(model, totalUsers);
      documentReference = await userCollection.add(model.toMap());
      documentReference.collection("items").add({});
      documentReference.collection("authorizedUsers").add({});
      return documentReference;
    } else
      //print("User Exists already");
      return documentReference;
  }

  @override
  Future<DocumentReference> findUser(UserAddingModel model) async {
    final userJSON = GoogleUserAddingModel.toJSON(model.toMap());
    final snapshot = await userCollection.get();
    try {
      final user = snapshot.docs
          .firstWhere((element) => element.data()['id'] == userJSON.userID);
      return user.reference;
    } catch (error) {
      //print("User was not found");
      return null;
    }
  }

  @override
  deleteUser() {}

  @override
  List findUsers<T>() {}
}

class QueryFirebase {
  final CollectionReference collection;

  QueryFirebase(this.collection);

  Future<int> totalUsers() async {
    final snapshot = await collection.get();
    return snapshot.docs.length + 1;
  }
}
