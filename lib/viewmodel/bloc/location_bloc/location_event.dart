import 'package:equatable/equatable.dart';

class LocationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationErrorEvent extends LocationEvent {
  final String msg;

  LocationErrorEvent(this.msg);
  @override
  List<Object> get props => [msg];
}
