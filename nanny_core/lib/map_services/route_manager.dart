import 'dart:math';

import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class RouteManager {
  static Future<Polyline?> calculateRoute({
    required LatLng origin, 
    required LatLng destination,
    String? id
  }) async {
    var result = await PolylinePoints().getRouteBetweenCoordinates(
      NannyConsts.mapKey, 
      PointLatLng(origin.latitude, origin.longitude), 
      PointLatLng(destination.latitude, destination.longitude),
    );

    Logger().i(
      "Google Map Directions request result:\n"
      "Status code: ${result.status}"
    );
    if(result.status != 'OK') return null;

    var points = result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
    return Polyline(
      polylineId: PolylineId(id ?? 'route'),
      points: points,
      color: NannyTheme.primary,
    );
  }

  static double computeDistance(Polyline route) {
    return SphericalUtils.computeDistanceFromListOfPoints(
      route.points.map(
        (e) => Point(e.longitude, e.latitude)
      ).toList()
    ).toDouble();
  }

  static double meters2Kilometers(double v) => v.roundToDouble() / 1000;
}