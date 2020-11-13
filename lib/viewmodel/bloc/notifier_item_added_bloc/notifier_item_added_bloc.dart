import 'package:bloc/bloc.dart';
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
      /*  final notificationPlugin = notification.FlutterLocalNotificationsPlugin();
      final initSettings = notification.AndroidInitializationSettings(null);
      await notificationPlugin.initialize(
          notification.InitializationSettings(android: initSettings));
      final andoridNotificaitonDetails =
          notification.AndroidNotificationDetails(
              "chennal", "channalname", "channal desc");
      final n =
          notification.NotificationDetails(android: andoridNotificaitonDetails);
      notificationPlugin.show(0, "My test", "My try", n);*/
      print("This is may Last added Document ${lastAddedDocument.data()}");
    }
  }
}
