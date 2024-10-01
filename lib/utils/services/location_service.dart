import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:venturo_food/global_controllers/global_controller.dart';

/// package geolocation belum bisa, temporary pakai location
// import 'package:geolocation/geolocation.dart';

class LocationService {
  /// Memastikan class ini tidak bisa diinstansiasi
  LocationService._();

  /// Ambil data lokasi menggunakan package Location
  static getCurrentLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    /// Request Service
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    /// Request Permission
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    /// Ambil location
    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;

    /// Pastikan tidak null setelah ambil lokasi
    if (lat == null || long == null) {
      return;
    }

    /// Reverse geocoding
    List<geo.Placemark> placemarks =
        await geo.placemarkFromCoordinates(lat, long);

    GlobalController.to.latitude.value = long;
    GlobalController.to.longitude.value = lat;
    GlobalController.to.address.value = [
      placemarks.first.name,
      placemarks.first.subLocality,
      placemarks.first.locality,
      placemarks.first.administrativeArea
    ].where((e) => e != null).join(', ');
  }
}
