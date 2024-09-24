import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:venturo_food/modules/global_controllers/global_controller.dart';

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






/// CODE DARI KELAS VENTURO, Belum ada repo
//   static Stream<ServiceStatus> streamService =
//       Geolocator.getServiceStatusStream();

//   /// Mendapatkan informasi lokasi
//   static Future<LocationResult> getCurrentPosition() async {
//     /// Apakah layanan lokasi aktif?
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       /// Jika tidak, kirim pesan error
//       return LocationResult.error(message: 'Location service not enabled');
//     }

//     /// Cek izin lokasi
//     LocationPermission permission = await Geolocator.checkPermission();

//     /// Apakah izin lokasi ditolak
//     if (permission == LocationPermission.denied) {
//       /// Jika tidak, minta izin
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         /// Jika izin ditolak, kirim pesan error
//         return LocationResult.error(
//           message: 'Location permission not granted',
//         );
//       }
//     }

//     /// Apakah izin lokasi ditolak selamanya
//     if (permission == LocationPermission.deniedForever) {
//       /// Jika izin lokasi ditolak selamanya, kirim pesan error
//       return LocationResult.error(
//         message: 'Location permission not granted forever',
//       );
//     }

//     /// Jika izin lokasi diberikan, ambil lokasi
//     late Position position;
//     try {
//       position = await Geolocator.getCurrentPosition();
//     } catch (e) {
//       return LocationResult.error(message: 'Location service not enabled');
//     }

//     /// Mendapatkan informasi jarak lokasi dalam meter
//     double distanceInMeters = Geolocator.distanceBetween(
//       position.latitude,
//       position.longitude,
//       AppConstants.locationLatitude,
//       AppConstants.locationLongitude,
//     );

//     /// Apakah jarak lokasi dekat dengan lokasi Java Code dalam radius yang ditentukan?
//     if (distanceInMeters > AppConstants.maximumDistance) {
//       /// Jika tidak, kirim pesan error
//       return LocationResult.error(message: 'Distance not close');
//     }

//     /// Ambil informasi lokasi
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position.latitude,
//       position.longitude,
//     );

//     if (placemarks.isEmpty) {
//       /// Jika tidak ada informasi lokasi, kirim pesan error
//       return LocationResult.error(message: 'Unknown location');
//     }

//     /// Jika ada informasi lokasi, kirim informasi lokasi
//     print('object');
//     return LocationResult.success(
//       position: position,
//       address: [
//         placemarks.first.name,
//         placemarks.first.subLocality,
//         placemarks.first.locality,
//         placemarks.first.administrativeArea,
//         placemarks.first.postalCode,
//         placemarks.first.country,
//       ].where((e) => e != null).join(', '),
//     );
//   }
// }

// class LocationResult {
//   final bool success;
//   final Position? position;
//   final String? address;
//   final String? message;

//   LocationResult({
//     required this.success,
//     this.position,
//     this.address,
//     this.message,
//   });

//   factory LocationResult.success(
//       {required Position position, required String address}) {
//     return LocationResult(
//       success: true,
//       position: position,
//       address: address,
//     );
//   }

//   factory LocationResult.error({required String message}) {
//     return LocationResult(
//       success: false,
//       message: message,
//     );
//   }

