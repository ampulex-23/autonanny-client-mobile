import 'dart:io';

import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/api_models/base_models/api_response.dart';
import 'package:nanny_core/api/dio_request.dart';
import 'package:nanny_core/api/request_builder.dart';
import 'package:nanny_core/constants.dart';
import 'package:nanny_core/map_services/location_service.dart';
import 'package:nanny_core/models/from_api/drive_and_map/geocoding_data.dart';

class GoogleMapApi {
  static Future<ApiResponse<GeocodeData>> reverseGeocode({required LatLng loc, String region = "ru"}) async {
    return RequestBuilder<GeocodeData>().create(
      dioRequest: DioRequest.dio.getUri(
        Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?"
          "latlng=${loc.latitude},${loc.longitude}"
          "&language=ru"
          "&region=$region"
          "&key=${Platform.isAndroid ? NannyConsts.androidMapApiKey : NannyConsts.iosMapApiKey}"
        )
      ),
      onSuccess: (response) => GeocodeData.fromJson(response.data),
    );
  }
  static Future<ApiResponse<GeocodeData>> geocode({required String address, String region = "ru"}) async {
    // String locality = "";

    //   var locs = LocationService.lastLocationInfo!.address.addressComponents
    //     .where((e) => e.types.contains(AddressType.locality))
    //     .toList();
      
    //   if(locs.isNotEmpty) {
    //     locality = locs.first.shortName;
    //   }
    LatLng? northEast, southWest;
    if(LocationService.lastLocationInfo != null) {
      var loc = LocationService.lastLocationInfo!.address.geometry!.location!;
      northEast = LatLng(
        loc.latitude + 1.5, 
        loc.longitude + 1.5,
      );
      southWest = LatLng(
        loc.latitude - 1.5,
        loc.longitude - 1.5,
      );
    }

    return RequestBuilder<GeocodeData>().create(
      dioRequest: DioRequest.dio.getUri(
        Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?"
          "address=$address"
          "&language=ru"
          "&components=country:RU"
          "${northEast != null ? "&bounds=${southWest!.latitude},${southWest.longitude}|${northEast.latitude},${northEast.longitude}" : ""}"
          // "&components=country:RU${locality.isNotEmpty ? "|locality:$locality" : ""}"
          "&region=$region"
          "&key=${Platform.isAndroid ? NannyConsts.androidMapApiKey : NannyConsts.iosMapApiKey}"
        )
      ),
      onSuccess: (response) => GeocodeData.fromJson(response.data),
    );
  }
}