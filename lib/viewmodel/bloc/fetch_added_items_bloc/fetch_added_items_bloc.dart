import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/fetch_added_items_bloc/fetch_added_items_event.dart';
import 'package:money_management/viewmodel/bloc/fetch_added_items_bloc/fetch_added_items_state.dart';

class FetchAddedAmountBloc
    extends Bloc<FetchAddedItemsEvent, FetchAddedItemsState> {
  FetchAddedAmountBloc() : super(null);

  @override
  Stream<FetchAddedItemsState> mapEventToState(
      FetchAddedItemsEvent event) async* {
    final firebaseService = FirebaseService();
    final googleUserIdBox = Hive.box(kGoogleUserId);
    final userID = googleUserIdBox.get("userID");
    final document = await firebaseService.findDocumentExistsByField(
        collectionName: "users",
        dataToMatch: {"id": userID},
        key1: "id",
        key2: "id");
    final collectionRefItems = document.reference
        .collection("items")
        .orderBy('auto_increment', descending: true);

    final List<ListOfTilesModel> items = [];
    final Future<List<ListOfTilesModel>> receivedData =
        collectionRefItems.get().then<List<ListOfTilesModel>>((snap) {
      final documents = snap.docs;

      documents.forEach((doc) {
        if (doc.data().isNotEmpty)
          items.add(ListOfTilesModel.fromJSON(doc.data()));
      });
      return items;
    }).catchError((error) {
      print("Error From Catch Then $error");
    });
    yield FetchAddedItemSuccessState(receivedData);
  }
}
