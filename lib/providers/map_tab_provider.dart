
import 'package:evently/common/app_constants.dart';
import 'package:evently/common/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTapProvider extends ChangeNotifier {
  Location location = Location();
  String locationMessage = '';
  PermissionStatus? permissionStatus;

  late GoogleMapController googleMapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );

  Set<Marker> markers = {};

  String? state;
  String? country;
  String? userState;
  String? userCountry;

  MapTapProvider() {
    getLocation();
    // setLocationListener();
  }

  Future<bool> getLocationPermission() async {
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    if (permissionStatus == PermissionStatus.deniedForever) {
      permissionStatus = PermissionStatus.denied;
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  Future<void> getLocation() async {
    bool permissionGranted = await getLocationPermission();
    if (!permissionGranted) {
      locationMessage = 'Location Permission Denied';
      notifyListeners();
      return;
    }

    bool serviceEnabled = await checkLocationService();
    if (!serviceEnabled) {
      locationMessage = 'Location Service disabled';
      notifyListeners();
      return;
    }
    locationMessage =
        'Location Service Enabled And Now We Are Getting Location';
    LocationData locationData = await location.getLocation();
    locationMessage =
        'Location: ${locationData.latitude}, ${locationData.longitude}';

    changeLocationOnMap(locationData);

    AppPrefs.userLocationLatitudeSetDouble(
        AppConstants.userLocationLatitudeKey, locationData.latitude ?? 0);
    AppPrefs.userLocationLongitudeSetDouble(
        AppConstants.userLocationLongitudeKey, locationData.longitude ?? 0);

    notifyListeners();
  }

  void changeLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 14.4746,
    );

    markers.clear();

    markers.add(
      Marker(
          markerId: MarkerId('1'),
          position:
              LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
          infoWindow: InfoWindow(title: 'Current Location')),
    );

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    notifyListeners();
  }

  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.high, interval: 1000);
    location.onLocationChanged.listen((LocationData currentLocation) {
      changeLocationOnMap(currentLocation);
      notifyListeners();
    });
  }

  void goToEventLocation(LatLng latLng, String eventTitle) {
    cameraPosition = CameraPosition(target: latLng, zoom: 14.4746);

    markers.removeWhere((marker) => marker.markerId.value == '1');

    markers.clear();

    markers.add(
      Marker(
          markerId: MarkerId(UniqueKey().toString()),
          position: LatLng(latLng.latitude, latLng.longitude),
          infoWindow: InfoWindow(title: eventTitle)),
    );

    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    notifyListeners();
  }

  Future<void> convertLatLngToAddress(LatLng latLng) async {
    List<geocoding.Placemark> placeMarks = await geocoding
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if (placeMarks.isNotEmpty) {
      state = placeMarks.first.administrativeArea ?? 'can not find state';
      country = placeMarks.first.country ?? 'can not find country';
    }
    notifyListeners();
  }

  Future<void> convertUserLatLngToAddress(LatLng latLng) async {
    List<geocoding.Placemark> placeMarks = await geocoding
        .placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    if (placeMarks.isNotEmpty) {
      userState = placeMarks.first.administrativeArea ?? 'can not find state';
      userCountry = placeMarks.first.country ?? 'can not find country';
    }
    notifyListeners();
  }
}
