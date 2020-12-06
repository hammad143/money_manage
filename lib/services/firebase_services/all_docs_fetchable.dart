import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AllDocsFetchAble<T> {
  Future<List<T>> fetchDocs(CollectionReference collectionReference);
  Future<CollectionReference> findCollection(
      CollectionReference collection, key, value, String desiredCollectionName);
}

class FetchAllDocsOfItems implements AllDocsFetchAble<QueryDocumentSnapshot> {
  @override
  Future<List<QueryDocumentSnapshot>> fetchDocs(
      CollectionReference collectionReference) async {
    final snaps = await collectionReference.get();
    return snaps.docs;
  }

  @override
  Future<CollectionReference> findCollection(CollectionReference collection,
      key, value, String desiredCollectionName) async {
    final snap = await collection.get();
    try {
      final doc =
          snap.docs.firstWhere((element) => element.data()[key] == value);
      final CollectionReference _collection =
          doc.reference.collection(desiredCollectionName);
      return _collection;
    } catch (error) {
      return null;
    }
  }
}
