import 'package:equatable/equatable.dart';
import 'package:money_management/model/location_model.dart';

class LocationState extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationInitState extends LocationState {}

class LocationAccessedState extends LocationState {
  final LocationModel location;

  LocationAccessedState(this.location);
}

class LocationErrorState extends LocationState {
  final String message;
  LocationErrorState(this.message);
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
