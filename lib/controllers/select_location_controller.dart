import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../api/map_service.dart';
import '../config/app_icons.dart';
import '../config/app_size.dart';
import '../config/app_strings.dart';

class SelectLocationController extends GetxController {
  RxSet<Marker> markers = <Marker>{}.obs;
  RxString userAddress = ''.obs;
  RxBool like = false.obs;
  BitmapDescriptor? customMarker;
  final MarkerId markerId = const MarkerId(AppStrings.currentLocation);
  LatLng? selectedDestination;
  GoogleMapController? myMapController;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  Rx<LatLng> initialLocation = const LatLng(-27.9628, 153.3814).obs;
  Rx<LatLng> userLocation = const LatLng(-27.9628, 153.3814).obs;
  RxInt selectedServiceIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  TextEditingController selectLocationController = TextEditingController();
  TextEditingController locationNameController = TextEditingController();

  @override
  void onInit() {
    _getCurrentLocation();
    createMarkers();
    loadCustomMarker();
    ever(userAddress, (_) {
      selectLocationController.text = userAddress.value;
    });
    super.onInit();
  }

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> loadCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      AppIcons.currentLocation,
    );
  }

  Set<Marker> createMarkers() {
    return <Marker>{
      Marker(
        markerId: markerId,
        position: initialLocation.value,
        icon: customMarker ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: AppStrings.yourCustomMarker),
        anchor: const Offset(0.8, 0.8),
      ),
    };
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
    addCustomMarker(
      LatLng(latitude.value, longitude.value),
      'currentLocation',
      '',
      '',
      BitmapDescriptor.fromBytes(await getBytesFromAsset(
          path: AppIcons.currentLocation,
          height: AppSize.size80.toInt(),
          width: AppSize.size80.toInt())),
    );
    await _getCurrentAddress(latitude.value, longitude.value);
    initialLocation.value = LatLng(latitude.value, longitude.value);
    update();
  }

  Future<String> _getCurrentAddress(double latitude, double longitude) async {
    const apiKey = AppStrings.key;
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      final results = decodedResponse['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        final address = results.first['formatted_address'] as String;
        userAddress.value = address;
        return address;
      }
    }

    return '';
  }

  Future<Uint8List> getBytesFromAsset(
      {required String path, int? width, int? height}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width ?? AppSize.size55.toInt(),
      targetHeight: height ?? AppSize.size55.toInt(),
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  setNearMarker(LatLng cord, String name, List types, String status,
      String address) async {
    final BitmapDescriptor markerIcon;

    // if (types.contains('library')) {
    //   markerIcon = BitmapDescriptor.fromBytes(
    //       await getBytesFromAsset(path: AppIcons.bikeIcon));
    // } else if (types.contains('park')) {
    //   markerIcon = BitmapDescriptor.fromBytes(
    //       await getBytesFromAsset(path: AppIcons.autoIcon));
    // } else if (types.contains('school')) {
    //   markerIcon = BitmapDescriptor.fromBytes(
    //       await getBytesFromAsset(path: AppIcons.carIcon));
    // } else {
    //   markerIcon = BitmapDescriptor.fromBytes(
    //       await getBytesFromAsset(path: AppIcons.mapIcon));
    // }
    markerIcon = BitmapDescriptor.fromBytes(
        await getBytesFromAsset(path: AppIcons.mapIcon));
    addCustomMarker(cord, name, name, address, markerIcon);
    update();
  }

  void addCustomMarker(LatLng latLng, String markerId, String placeName,
      String address, BitmapDescriptor icon) {
    markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: latLng,
        icon: icon,
        infoWindow: InfoWindow(
          title: placeName,
          snippet: address,
        ),
        onTap: () {
          onMarkerTap(latLng);
        },
      ),
    );

    if (selectedDestination != null) {
      markers.add(
        Marker(
          markerId: const MarkerId(AppStrings.selectedDestinationMarker),
          position: LatLng(
              selectedDestination!.latitude, selectedDestination!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(
            title: AppStrings.selectedDestination,
            snippet: AppStrings.yourSelectedDestination,
          ),
        ),
      );
    }
    update();
  }

  void onMarkerTap(LatLng latLng) {}
  gMapsFunctionCall(context) {
    Timer(const Duration(seconds: 2), () async {
      // var libraryPlaceResult = await MapServices()
      //     .nearByPlaceDetailsAPI(const LatLng(-27.7241, 153.1137),
      //     16093.4.toInt(), "library");
      var parkPlaceResult = await MapServices().nearByPlaceDetailsAPI(
          const LatLng(-27.9628, 153.3814), 1009.4.toInt(), "park");

      List<dynamic> placeWithinList = (parkPlaceResult['results']) as List;
      // allMarkerList.clear();
      // allMarkerList.addAll(placeWithinList);

      for (var element in placeWithinList) {
        setNearMarker(
            LatLng(element['geometry']['location']['lat'],
                element['geometry']['location']['lng']),
            element['name'],
            element['types'],
            element['business_status'] ?? 'not available',
            element['vicinity']);
      }
    });
  }

  List<String> locationPlaces = [
    AppStrings.home,
    AppStrings.office,
    AppStrings.other,
  ];
}
