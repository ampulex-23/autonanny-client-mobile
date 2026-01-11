class SOSActivateRequest {
  SOSActivateRequest({
    this.latitude,
    this.longitude,
    this.message,
    this.idOrder,
  });

  final double? latitude;
  final double? longitude;
  final String? message;
  final int? idOrder;

  Map<String, dynamic> toJson() {
    return {
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (message != null) 'message': message,
      if (idOrder != null) 'id_order': idOrder,
    };
  }
}
