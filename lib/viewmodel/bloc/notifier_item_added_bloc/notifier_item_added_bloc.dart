import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notification;
import 'package:geocoder/geocoder.dart';
import 'package:hive/hive.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/notifier.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_event.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_state.dart';

class NotifierItemAddedBloc
    extends Bloc<NotifierItemAddedEvent, NotifierItemAddedState> {
  NotifierItemAddedBloc({NotifierItemAddedState initialState})
      : super(NotifierItemAddedInitState());

  @override
  Stream<NotifierItemAddedState> mapEventToState(
      NotifierItemAddedEvent event) async* {
    final currencyBox = Hive.box(kSelectedCurrency);
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

          final lat = lastItem.latitude;
          final long = lastItem.longitude;
          final addresses = await Geocoder.local
              .findAddressesFromCoordinates(Coordinates(lat, long));
          final address = addresses.first;
          final currency = currencyBox.get("currency");
          final notificationChannelDetails =
              notification.AndroidNotificationDetails(
            "my_channel_id",
            "Channel Name",
            "Here is the channel description",
            priority: notification.Priority.max,
            importance: notification.Importance.max,
            enableVibration: true,
            fullScreenIntent: true,
            indeterminate: true,
            styleInformation: notification.BigTextStyleInformation(
                "$currency ${lastItem.amount} was ${lastItem.option} due to/for ${lastItem.title} at ${lastItem.dateInString} in\n${address.addressLine}",
                htmlFormatBigText: true,
                htmlFormatSummaryText: true,
                htmlFormatContentTitle: true,
                htmlFormatContent: true,
                htmlFormatTitle: true,
                contentTitle:
                    "${lastItem.title} in ${address.subLocality}, ${address.locality}",
                summaryText: "<h1> Added By ${document.data()['name']}</h1>"),
          );

          final platformNotification = notification.NotificationDetails(
            android: notificationChannelDetails,
          );
          final plugin = FlutterLocalNotifier().plugin;

          notification.BigTextStyleInformation("${lastItem.title}");

          plugin.show(
            0,
            "",
            "Amount ${lastItem.amount} ,  ${lastItem.option}, Time: ${lastItem.dateInString}",
            platformNotification,
          );
        } else {
          print("Item Already notified");
        }
      }); //Listener

    }
  }
}
