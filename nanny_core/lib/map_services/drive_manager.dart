import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/models/from_api/drive_and_map/geocoding_data.dart';
import 'package:nanny_core/nanny_core.dart';

class DriveManager {
  DriveManager({
    required this.routes,
    required this.addresses,
  }) {
    assert(routes.isNotEmpty);
    assert(addresses.length - 1 == routes.length);
  }

  final List<Polyline> routes;
  final List<GeocodeResult> addresses;

  Polyline get currentRoute => routes[_currentRouteIndex];
  bool get onLastRoute => currentRoute == routes.last;

  int _currentRouteIndex = 0;

  /// Returns `true` if route changed
  bool nextRoute() {
    if(_currentRouteIndex < routes.length - 1) {
      _currentRouteIndex++;
      return true;
    }
    else {
      return false;
    }
  }

  double getDistanceToFirstPoint(LatLng loc) => SphericalUtils.computeDistanceBetween(
    NannyMapUtils.latLng2Point(loc), 
    NannyMapUtils.latLng2Point(currentRoute.points.first)
  ).toDouble();

  bool isAtRouteEnd(LatLng loc, {double maxDistance = 100}) {
    double distance = SphericalUtils.computeDistanceBetween(
      NannyMapUtils.latLng2Point(loc),
      NannyMapUtils.latLng2Point(currentRoute.points.last),
    ).toDouble();

    return distance <= 100;
  }

  Future<bool> redrawRoute(LatLng loc) async {
    var route = await RouteManager.calculateRoute(
      origin: loc, 
      destination: currentRoute.points.last,
    );

    if(route == null) return false;

    routes[_currentRouteIndex] = route;
    return true;
  }

  DriveUpdateResult updateDriveRoute(
    LatLng loc, 
    {
      double maxSeacrhDistance = 15, 
    }
  ) {
    int pointIndex = PolyUtils.locationIndexOnPathTolerance(
      NannyMapUtils.latLng2Point(loc), 
      NannyMapUtils.polyline2Points(currentRoute), 
      false, 
      maxSeacrhDistance,
    );

    if(pointIndex < 0) return DriveUpdateResult(loc: loc, route: currentRoute, onPath: false);
    Logger().w("Index position on polyline: $pointIndex");

    var a = currentRoute.points[pointIndex];
    var b = currentRoute.points[pointIndex + 1];

    var updatedPos = _findDirectionalPoint(a, b, loc);
    var updatedRoute = currentRoute..clone();
    updatedRoute.points
      ..removeRange(0, pointIndex + 1)
      ..insert(0, updatedPos);

    double heading = getHeading(a, b);

    return DriveUpdateResult(loc: updatedPos, heading: heading, route: updatedRoute, onPath: true);
  }

  double getHeading(LatLng a, LatLng b) {
    return 360 - SphericalUtils.computeHeading(
      NannyMapUtils.latLng2Point(a), 
      NannyMapUtils.latLng2Point(b)
    ).toDouble() + 90;
  }

  LatLng _findDirectionalPoint(LatLng start, LatLng end, LatLng loc) {
    var pointA = NannyMapUtils.latLng2Point(start);
    var pointB = NannyMapUtils.latLng2Point(end);

    double pathAngle = SphericalUtils.computeAngleBetween(
      pointA,
      pointB,
    ).toDouble();

    double dirAngle = SphericalUtils.computeAngleBetween(
      pointA,
      NannyMapUtils.latLng2Point(loc),
    ).toDouble();

    double fraction = dirAngle / pathAngle;

    var pos = SphericalUtils.interpolate(
      pointA,
      pointB,
      fraction,
    );

    return NannyMapUtils.point2LatLng(pos);
  }

  // double _getVectorDotFrom(LatLng pA, LatLng pB, LatLng loc) {
  //   var a = Vector2.fromLatLng(pA);
  //   var b = Vector2.fromLatLng(pB);
  //   var curLoc = Vector2.fromLatLng(loc);

  //   var dirA = b - a;
  //   var dirB = curLoc - a;

  //   return dirB.dot(dirA);
  // }
}

class DriveUpdateResult {
  DriveUpdateResult({
    required this.loc,
    required this.route,
    required this.onPath,
    this.heading,
  });

  final LatLng loc;
  final Polyline route;
  final bool onPath;
  final double? heading;
}

// class Vector2 {
//   Vector2(
//     this.x,
//     this.y
//   );

//   Vector2.fromPoint(Point p) {
//     x = p.x.toDouble();
//     y = p.y.toDouble();
//   }

//   Vector2.fromLatLng(LatLng p) {
//     x = p.longitude;
//     y = p.latitude;
//   }

//   late double x;
//   late double y;

//   Vector2 operator -(Vector2 other) => Vector2(x - other.x, y - other.y);
//   Vector2 operator +(Vector2 other) => Vector2(x + other.x, y + other.y);
//   Vector2 operator *(double number) => Vector2(x * number, y * number);
  
//   double magnitude() => sqrt(x * x + y * y);
//   Vector2 normalized() => Vector2(x / magnitude(), y / magnitude());
//   static double dotProduct(Vector2 a, Vector2 b) => a.x * b.x + a.y * b.y;
//   double dot(Vector2 b) {
//     return dotProduct(this, b) / (magnitude() * b.magnitude());
//   }
// }