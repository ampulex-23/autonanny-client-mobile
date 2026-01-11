import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class MapViewer extends StatefulWidget {
  final Widget body;
  final Widget panel;
  final String? currentLocName;
  final double minExtent;
  final double maxExtent;
  final GoogleMapController Function()? onPosPressed;
  final void Function(ScrollController sc)? onPanelBuild;

  const MapViewer({
    super.key,
    required this.body,
    required this.panel,
    this.currentLocName,
    this.onPosPressed,
    this.minExtent = .1,
    this.maxExtent = .5,
    this.onPanelBuild,
  });

  @override
  State<MapViewer> createState() => _MapViewerState();
}

class _MapViewerState extends State<MapViewer> {
  double panelPos = 0;
  double minHeight = 0;
  double maxHeight = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptBuilder(builder: (context, size) {
      minHeight = size.height * widget.minExtent;
      maxHeight = size.height * widget.maxExtent;

      return SlidingUpPanel(
        minHeight: minHeight,
        maxHeight: maxHeight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        parallaxEnabled: true,
        body: Stack(
          children: [
            widget.body,
            IgnorePointer(
              child: widget.currentLocName != null
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: kToolbarHeight),
                          const Text("Ваш адрес >",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Card(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                widget.currentLocName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
            if (widget.onPosPressed != null)
              Positioned(
                right: 20,
                bottom: minHeight + 100 + ((maxHeight - minHeight) * panelPos),
                child: FloatingActionButton(
                  heroTag: "MylocBtn",
                  onPressed: toMyPos,
                  child: const Icon(Icons.location_searching),
                ),
              )
          ],
        ),
        onPanelSlide: widget.onPosPressed != null
            ? (position) => setState(() {
                  panelPos = position;
                })
            : null,
        panelBuilder: (sc) {
          widget.onPanelBuild?.call(sc);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Opacity(
                  opacity: .5,
                  child: Container(
                    width: 80,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              Expanded(child: widget.panel),
            ],
          );
        },
      );
    });
  }

  void toMyPos() async {
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

      LocationService.curLoc ??= await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      GoogleMapController? controller = widget.onPosPressed!.call();
      var location = LocationService.curLoc;
      if (location == null) return;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: NannyMapUtils.position2LatLng(location),
        zoom: 15,
      )));
    } catch (e) {
      // Игнорируем ошибки геолокации
      print('Error getting location: $e');
    }
  }
}
