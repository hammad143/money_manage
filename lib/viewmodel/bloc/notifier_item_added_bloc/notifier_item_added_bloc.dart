import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notification;
import 'package:money_management/services/firebase_services/firebase_service.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_event.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_state.dart';

class NotifierItemAddedBloc
    extends Bloc<NotifierItemAddedEvent, NotifierItemAddedState> {
  NotifierItemAddedBloc({NotifierItemAddedState initialState})
      : super(NotifierItemAddedInitState());

  @override
  Stream<NotifierItemAddedState> mapEventToState(
      NotifierItemAddedEvent event) async* {
    final firebaseService = FirebaseService();
    final appKey = event.key;
    final document = await firebaseService.findDocumentExistsByField(
      collectionName: "users",
      dataToMatch: {"appKey": appKey},
      key1: "appKey",
      key2: "appKey",
    );
    if (document != null) {
      final snapshot = await document.reference.collection("items");
      snapshot.snapshots().listen((event) async {
        print("I'm the listener on Stream when data is added");
        print("check if my listner working");
        DocumentSnapshot lastAddedDocument;
        lastAddedDocument = event.docs.firstWhere((element) {
          print("check if my listner working 2");
          final data = element.data();
          int lastAddedIndex;
          final doc = event.docs.firstWhere((element) {
            final items = element.data();
            final item1 = data['auto_increment'] ?? 0;
            final item2 = items['auto_increment'] ?? 0;
            return item1 > item2;
          });
          lastAddedIndex = doc.data()['auto_increment'];
          print("Thhis is the index ${lastAddedIndex}");
          if (lastAddedIndex != null)
            return true;
          else
            return false;
        });

        final data = lastAddedDocument.data();
        final androidInitSetting =
            notification.AndroidInitializationSettings('app_icon');
        final initSettings =
            notification.InitializationSettings(android: androidInitSetting);
        final plugin = notification.FlutterLocalNotificationsPlugin();
        await plugin.initialize(initSettings);
        final notificationChannelDetails =
            notification.AndroidNotificationDetails("my_channel_id",
                "Channel Name", "Here is the channel description",
                priority: notification.Priority.high,
                importance: notification.Importance.max,
                enableVibration: true,
                fullScreenIntent: true,
                indeterminate: true,
                maxProgress: 70);
        final platformNotification = notification.NotificationDetails(
            android: notificationChannelDetails);
        plugin.show(
            0,
            "${data['title']}",
            "Amount ${data['amount']}, Option: ${data['option']} added at: ${data['date']}",
            platformNotification);
      });
    }
  }
}
