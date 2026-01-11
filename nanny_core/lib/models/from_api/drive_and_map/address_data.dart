import 'package:nanny_components/nanny_components.dart';

class DriveAddress {
  DriveAddress({
    required this.fromAddress,
    required this.toAddress
  });

  AddressData fromAddress;
  AddressData toAddress;

  DriveAddress.fromJson(Map<String, dynamic> json)
    : fromAddress = AddressData.fromJson(json["from_address"]),
      toAddress = AddressData.fromJson(json["to_address"]);

  Map<String, dynamic> toJson() => {
    "from_address": fromAddress.toJson(),
    "to_address": toAddress.toJson()
  };
}

class AddressData {
  AddressData({
    required this.address,
    required this.location
  });

  final String address;
  final LatLng location;

  AddressData.fromJson(Map<String, dynamic> json)
    : address = json["address"] ?? "",
      location = LatLng(json["location"]["latitude"], json["location"]["longitude"]);
    
  Map<String, dynamic> toJson() => {
    "address": address,
    "location": {
      "latitude": location.latitude,
      "longitude": location.longitude,
    }
  };
}