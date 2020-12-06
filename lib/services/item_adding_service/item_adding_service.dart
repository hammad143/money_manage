import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_management/model/tiles_item_model/item_model.dart';
import 'package:money_management/model/user_adding_decorator/user_adding_decorator.dart';
import 'package:money_management/model/user_adding_model/model.dart';
import 'package:money_management/services/firebase_services/all_docs_fetchable.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/boxes_facade/boxes_facade.dart';

class ItemAddingService implements FBService<Future<Model>> {
  BoxesFacade boxesFacade = BoxesFacade();
  CollectionReference _itemCollection;

  @override
  Future<Model> addDoc(Model model) async {
    final snap = await collection.get();
    final uniqueIdBox = boxesFacade.getUserUniqueKeyBox();
    try {
      final user = snap.docs.firstWhere((element) {
        final data = element.data();
        final id = uniqueIdBox.get(boxesFacade.userUniqueKey);
        return id == data['id'];
      });

      _itemCollection = user.reference.collection("items");
      final totalItem = await totalDoc(_itemCollection);
      final updatedModel = ItemAddingDecorator(model, totalItem);
      await _itemCollection.add(updatedModel.toMap());
      return model;
    } catch (error) {
      print("User was not added");
      return null;
    }
  }

  Future<int> totalDoc(CollectionReference ref) async {
    final snaps = await ref.get();
    return snaps.docs.length;
  }

  @override
  deleteDoc() {
    // TODO: implement deleteDoc
    throw UnimplementedError();
  }

  @override
  Future<ItemsAddingModel> findDoc(Model model) {}

  @override
  List findDocs() {
    // TODO: implement findDocs
    throw UnimplementedError();
  }

  @override
  CollectionReference get collection =>
      FirebaseFirestore.instance.collection("users");
  @override
  Future<List<Model>> getDocs() async {
    List<Model> m = <Model>[];
    AllDocsFetchAble docsFetchAble = FetchAllDocsOfItems();
    final userID =
        boxesFacade.getUserUniqueKeyBox().get(boxesFacade.userUniqueKey);
    if (userID != null) {
      try {
        _itemCollection = await docsFetchAble.findCollection(
            collection, "id", userID, "items");
        final docs = await docsFetchAble.fetchDocs(_itemCollection);
        docs.forEach((element) {
          m.add(ItemsAddingModel.toJSON(element.data()));
        });
        return m;
      } catch (error) {
        print("USER IS NOT FOUND FOR ITEM");
        return null;
      }
    } else {
      print("USER WAS NOT LOGGED IN");
      return m;
    }
  }
}
