// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:nanny_client/views/map/driver_search.dart';
import 'package:nanny_components/dialogs/loading.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/api_models/onetime_drive_request.dart';
import 'package:nanny_core/api/nanny_orders_api.dart';
import 'package:nanny_core/models/from_api/drive_and_map/address_data.dart';
import 'package:nanny_core/models/from_api/drive_and_map/drive_tariff.dart';
import 'package:nanny_core/models/from_api/drive_and_map/geocoding_data.dart';
import 'package:nanny_core/nanny_core.dart';

class DriveOrderVM extends ViewModelBase {
  DriveOrderVM({
    required super.context,
    required super.update,
    required this.initAddress,
  }) {
    var curLoc = LocationService.curLoc;
    if (curLoc == null) {
      _initLocation();
    } else {
      update(() {
        addresses = [
          AddressData(
              address: initAddress.formattedAddress,
              location: initAddress.geometry?.location ??
                  NannyMapUtils.position2LatLng(curLoc!)),
        ];
      });
    }
    NannyOrdersApi.getCurrentOrder().then((v) {
      if(v.success) {
        var data = v.response;
        dev.log('current data ${data?.data}');
      } else {
        print('gotten error ${v.errorMessage}');
        print('gotten error ${v.response?.data}');
      }
    });
  }

  final GeocodeResult initAddress;
  List<AddressData> addresses = [];
  double distance = 0;
  double duration = 0;

  ValueNotifier<Set<Marker>> markers = NannyMapGlobals.markers;

  Future<void> _initLocation() async {
    try {
      // Проверяем разрешения
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position v = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      LocationService.curLoc = v;
      print('current location $v');
      
      update(() {
        addresses = [
          AddressData(
              address: initAddress.formattedAddress,
              location: initAddress.geometry?.location ??
                  NannyMapUtils.position2LatLng(v)),
        ];
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  List<DriveTariff> tariffs = [];
  DriveTariff? selectedTariff;

  bool get validDrive => addresses.length > 1 && selectedTariff != null;

  void calculatePrices() async {
    LoadScreen.showLoad(context, true);

    NannyMapGlobals.routes.value.clear();
    distance = 0;
    duration = 0;
    for (int i = 0; i < addresses.length - 1; i++) {
      var origin = addresses[i].location;
      var dest = addresses[i + 1].location;

      var polyRes = await PolylinePoints().getRouteBetweenCoordinates(
        NannyConsts.mapKey,
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(dest.latitude, dest.longitude),
      );

      distance += SphericalUtils.computeDistanceBetween(
          Point(origin.longitude, origin.latitude),
          Point(dest.longitude, dest.latitude));
      duration += polyRes.durationValue!;

      var route = await RouteManager.calculateRoute(
          origin: origin, destination: dest, id: "route_$i");

      if (route == null) continue;

      NannyMapGlobals.routes.value.add(route);
    }

    NannyMapGlobals.routes.notifyListeners();
    if (!context.mounted) return;

    distance /= 1000;
    duration /= 60;

    var res = await DioRequest.handle(context,
        NannyOrdersApi.getOnetimePrices(duration.ceil(), distance.ceil()));

    if (!res.success) return;

    var priceTars = res.data!;
    for (var tar in tariffs) {
      var tariff = priceTars.where((e) => e.id == tar.id).firstOrNull;
      if (tariff == null) continue;

      tar.amount = tariff.amount!;
    }
    LoadScreen.showLoad(context, false);
    update(() {});
  }

  void onAdd(AddressData address) {
    addresses.add(address);

    markers.value.add(Marker(
      markerId: MarkerId(address.address),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          HSLColor.fromColor(NannyTheme.primary).hue),
      position: address.location,
    ));

    markers.notifyListeners();
    calculatePrices();
    update(() {});
  }

  void onChange(AddressData oldAd, AddressData newAd) {
    int index = addresses.indexOf(oldAd);
    addresses.removeAt(index);
    addresses.insert(index, newAd);

    markers.value.removeWhere((e) => e.markerId == MarkerId(oldAd.address));
    markers.value.add(Marker(
      markerId: MarkerId(newAd.address),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          HSLColor.fromColor(NannyTheme.primary).hue),
      position: newAd.location,
    ));

    markers.notifyListeners();
    calculatePrices();
    update(() {});
  }

  void onDelete(AddressData address) {
    addresses.remove(address);

    markers.value.removeWhere((e) => e.markerId == MarkerId(address.address));

    markers.notifyListeners();
    calculatePrices();
    update(() {});
  }

  void searchForDrivers() async {
    List<DriveAddress> driveAddresses = [];

    for (int i = 0; i < addresses.length - 1; i++) {
      driveAddresses.add(
          DriveAddress(fromAddress: addresses[i], toAddress: addresses[i + 1]));
    }
    if (LocationService.curLoc == null) return;
    var res = await DioRequest.handle(
        context,
        NannyOrdersApi.startOnetimeOrder(OnetimeDriveRequest(
            myLocation: LocationService.curLoc,
            addresses: driveAddresses,
            price: selectedTariff!.amount!.toInt(),
            distance: distance.ceil(),
            duration: duration.ceil(),
            description: "",
            typeDrive: DriveType.oneWay.id,
            idTariff: selectedTariff!.id,
            otherParametrs: [])));

    if (!res.success) return;
    print('res data ${res.data}');
    // if(!context.mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DriverSearchView(token: res.data!)));
    });
  }

  void selectTariff(DriveTariff tariff) {
    selectedTariff = tariff;
    update(() {});
  }

  @override
  Future<bool> loadPage() async {
    var res = await NannyStaticDataApi.getTariffs();

    if (!res.success) return false;
    tariffs = res.response!;

    return true;
  }
}
