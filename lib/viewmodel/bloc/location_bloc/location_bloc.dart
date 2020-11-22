import 'package:bloc/bloc.dart';
import 'package:money_management/model/location_model.dart';
import 'package:money_management/services/location_service/location_service.dart';
import 'package:money_management/viewmodel/bloc/location_bloc/location_event.dart';
import 'package:money_management/viewmodel/bloc/location_bloc/location_state.dart';

//countryName , subLocality->Koranig, adminArea -> singh , locality -> Karachi

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitState());

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    print("Event ======================================");
    final address = await LocationSerivce().locationAccess();
    if (address != null) {
      final locationModel = LocationModel(
          countryName: address.countryName,
          city: address.locality,
          town: address.subLocality,
          province: address.adminArea,
          lat: address.coordinates.latitude,
          long: address.coordinates.longitude);
      yield LocationAccessedState(locationModel);
    }
  }
}
