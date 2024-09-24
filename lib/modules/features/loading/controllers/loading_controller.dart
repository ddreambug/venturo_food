import 'package:get/get.dart';
import 'dart:async';

///package alt geolocator
import 'package:location/location.dart' as loc;

///package alt geocoding
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingController extends GetxController {
  static LoadingController get to => Get.find();

  /// Animasi loading
  var animationPlay = false.obs;
  var buttonToggled = false.obs;
  var loadingDots = ''.obs;
  var loadingNextPage = 11.obs;
  Timer? _animationTimer;

  /// Properti lokasi
  RxnDouble lat = RxnDouble();
  RxnDouble long = RxnDouble();
  RxnString address = RxnString();
  RxBool isLoading = true.obs;
  String gMapsApiKey = 'AIzaSyDXNtvjPjr5keR8Vk6f6aX1V-0XeSQRbsc';

  @override
  void onInit() async {
    super.onInit();
    toggleBackgroundLoop();
    toggleLoadingTextAnimation();
    toggleButtonAnimation();
    toggleCountdownAnimation();
    getCurrentLocation();
  }

  @override
  void onClose() {
    _animationTimer?.cancel();
    super.onClose();
  }

  /// Animation Text ...
  void toggleLoadingTextAnimation() {
    _animationTimer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (loadingDots.value.length < 3) {
        loadingDots.value += '.';
      } else {
        loadingDots.value = '';
      }
    });
  }

  /// Animation auto next
  void toggleCountdownAnimation() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (loadingNextPage.value > 0) {
        loadingNextPage.value--;
      } else {
        timer.cancel();
        Get.offAllNamed('/counter');
      }
    });
  }

  /// Animation delay button cancel
  void toggleButtonAnimation() {
    Future.delayed(const Duration(seconds: 2));
    buttonToggled.value = true;
  }

  /// Toggle posisi background
  void toggleBackgroundAnimation() {
    animationPlay.value = !animationPlay.value;
  }

  /// Looping posisi background
  void toggleBackgroundLoop() {
    _animationTimer =
        Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      toggleBackgroundAnimation();
    });
  }

  /// Ambil alamat pake pub Location
  void getCurrentLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;
    loc.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    lat.value = locationData.latitude;
    long.value = locationData.longitude;
    await getLocationAddress(locationData.latitude!, locationData.longitude!);
    isLoading.value = false;
  }

  /// Parse alamat pake api googlemaps
  Future<void> getLocationAddress(double lat, double long) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$gMapsApiKey');

    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final jalan =
        responseData['results'][0]['address_components'][1]['long_name'];
    final kelurahan =
        responseData['results'][0]['address_components'][2]['long_name'];
    final kecamatan =
        responseData['results'][0]['address_components'][4]['long_name'];
    final kota =
        responseData['results'][0]['address_components'][5]['long_name'];

    address.value = '$jalan, $kelurahan, $kecamatan, $kota';
  }
}
