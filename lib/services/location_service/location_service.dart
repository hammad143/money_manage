import 'package:geocoder/geocoder.dart' as geoCoder;
import 'package:location/location.dart' as locationManager;

class LocationSerivce {
  Future<geoCoder.Address> locationAccess() async {
    locationManager.PermissionStatus premissionStatus;
    final hasPermission =
        await locationManager.Location.instance.hasPermission();
    if (hasPermission.index == 0) {
      premissionStatus =
          await locationManager.Location.instance.requestPermission();
      final isLocationOn =
          await locationManager.Location.instance.requestService();
      if (isLocationOn) {
        final cords = await locationManager.Location.instance.getLocation();
        final decodedCords =
            await geoCoder.Coordinates(cords.latitude, cords.longitude);
        final address = (await geoCoder.Geocoder.local
                .findAddressesFromCoordinates(decodedCords))
            .first;
        return address;
      }
    } else {
      print("Location Don't have permission");
      return null;
    }
  }
}
