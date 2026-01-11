import 'package:flutter/material.dart';
import 'package:nanny_core/models/from_api/drive_and_map/geocoding_data.dart';

class AddressViewData {
  TextEditingController controller;
  GeocodeResult? address;

  // Добавляем параметр address в конструктор
  AddressViewData({this.address, required this.controller});
}
