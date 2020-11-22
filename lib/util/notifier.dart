import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notification;

class FlutterLocalNotifier {
  static notification.FlutterLocalNotificationsPlugin _plugin;
  static init() async {
    final androidInitSetting =
        notification.AndroidInitializationSettings('@drawable/app_icon1');
    final initSettings =
        notification.InitializationSettings(android: androidInitSetting);
    _plugin = notification.FlutterLocalNotificationsPlugin();
    bool isInitialized = await _plugin.initialize(initSettings);
    if (isInitialized)
      return _plugin;
    else
      return null;
  }

  notification.FlutterLocalNotificationsPlugin get plugin => _plugin;
}
