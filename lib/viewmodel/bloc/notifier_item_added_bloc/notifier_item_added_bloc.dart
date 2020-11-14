import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notification;
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_event.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_state.dart';

class NotifierItemAddedBloc
    extends Bloc<NotifierItemAddedEvent, NotifierItemAddedState> {
  NotifierItemAddedBloc({NotifierItemAddedState initialState})
      : super(NotifierItemAddedInitState());

  @override
  Stream<NotifierItemAddedState> mapEventToState(
      NotifierItemAddedEvent event) async* {
    if (event.querySnapshot != null) {
      final querySnapshot = event.querySnapshot;
      final documents = event.querySnapshot.docs;

      final lastAddedDocument = documents.firstWhere((element) {
        final data = element.data();
        return data['auto_increment'] == documents.length;
      });
      if (lastAddedDocument != null) {
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
        print("This is may Last added Document ${lastAddedDocument.data()}");
      }
    }
  }
}
