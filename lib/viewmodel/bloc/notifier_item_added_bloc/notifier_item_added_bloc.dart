import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notification;
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_event.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_state.dart';

class NotifierItemAddedBloc
    extends Bloc<NotifierItemAddedEvent, NotifierItemAddedState> {
  NotifierItemAddedBloc({NotifierItemAddedState initialState})
      : super(NotifierItemAddedInitState());

  @override
  Stream<NotifierItemAddedState> mapEventToState(
      NotifierItemAddedEvent event) async* {
    final lastItemAddedBox = Hive.box(kLastAddedItemOfAuthorizedUserKey);
    final firebaseService = FirebaseService();
    final appKey = event.key;
    final document = await firebaseService.findDocumentExistsByField(
      collectionName: "users",
      dataToMatch: {"appKey": appKey},
      key1: "appKey",
      key2: "appKey",
    );
    if (document != null) {
      final snapshot =
          document.reference.collection("items").orderBy('auto_increment');
      snapshot.snapshots().listen((event) async {
        print("I'm the listener on Stream when data is added");
        print("check if my listner working");
        final documents = event.docs;
        int greatestNumber = 0;
        List<int> mySortList = [];
        final itemData = documents.last.data();
        final lastItem = ListOfTilesModel.fromJSON(itemData);
        //Check Last Item
        if (lastItemAddedBox.get("lastItem") == null ||
            lastItemAddedBox.get("lastItem") != itemData['auto_increment']) {
          final lastItem = ListOfTilesModel.fromJSON(itemData);
          lastItemAddedBox.put("lastItem", itemData['auto_increment']);
          final androidInitSetting =
              notification.AndroidInitializationSettings('logo_icon');
          final initSettings =
              notification.InitializationSettings(android: androidInitSetting);
          final plugin = notification.FlutterLocalNotificationsPlugin();
          await plugin.initialize(initSettings);
          final notificationChannelDetails =
              notification.AndroidNotificationDetails("my_channel_id",
                  "Channel Name", "Here is the channel description",
                  priority: notification.Priority.min,
                  importance: notification.Importance.low,
                  enableVibration: true,
                  fullScreenIntent: true,
                  indeterminate: true,
                  maxProgress: 70);
          final platformNotification = notification.NotificationDetails(
              android: notificationChannelDetails);
          plugin.show(
              0,
              "${lastItem.title} By ${document.data()['name']}",
              "Amt ${lastItem.amount} , Opt ${lastItem.option}: T: ${lastItem.dateInString}",
              platformNotification);
        } else {
          print("Item Already notified");
        }
      }); //Listener

    }
  }
}
