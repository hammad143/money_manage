import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_management/model/user_adding_model/model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/boxes_facade/boxes_facade.dart';

class ItemAddingService implements FBService {
  BoxesFacade boxesFacade = BoxesFacade();

  @override
  addDoc(Model model) async {
    //final itemModel = model as ItemsAddingModel;
    final map = model.toMap();
    print("|||||||||||| ${model.toMap()} |||||||||||||||");
    final snap = await collection.get();
    final uniqueIdBox = boxesFacade.getUserUniqueKeyBox();

    try {
      final user = snap.docs.firstWhere((element) {
        final data = element.data();
        final id = uniqueIdBox.get(boxesFacade.userUniqueKey);
        return id == data['id'];
      });
      user.reference.collection("items").add(model.toMap());
    } catch (error) {
      print("User was not added");
      return null;
    }
  }

  @override
  deleteDoc() {
    // TODO: implement deleteDoc
    throw UnimplementedError();
  }

  @override
  findDoc(Model model) {}

  @override
  List findDocs<T>() {
    // TODO: implement findDocs
    throw UnimplementedError();
  }

  @override
  CollectionReference get collection =>
      FirebaseFirestore.instance.collection("users");
}
