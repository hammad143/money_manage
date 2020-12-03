import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_management/jose/firebase_services/firebase_service.dart';
import 'package:money_management/model/user_adding_model/user_adding_model.dart';

class ItemAddingService implements FBService {
  @override
  addDoc(UserAddingModel model) {
    // TODO: implement addDoc
    throw UnimplementedError();
  }

  @override
  deleteDoc() {
    // TODO: implement deleteDoc
    throw UnimplementedError();
  }

  @override
  findDoc(UserAddingModel model) {
    // TODO: implement findDoc
    throw UnimplementedError();
  }

  @override
  List findDocs<T>() {
    // TODO: implement findDocs
    throw UnimplementedError();
  }

  @override
  // TODO: implement userCollection
  CollectionReference get userCollection => throw UnimplementedError();
 
}