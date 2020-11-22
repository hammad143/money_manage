import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifierItemAddedEvent extends Equatable {
  final String key;
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;
  NotifierItemAddedEvent(this.key, {this.flutterLocalNotificationPlugin});

  @override
  List<Object> get props => [];
}
