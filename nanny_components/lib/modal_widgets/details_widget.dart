import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/models/from_api/drive_and_map/drive_tariff.dart';
import 'package:nanny_core/models/order.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      addresses(),
      const SizedBox(height: 24),
      tariffInfo(),
      const SizedBox(height: 68),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Отменить заказ')))
          ])),
      const SizedBox(height: 40)
    ]);
  }

  Widget addresses() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
          children: order.addresses
              .map((e) => Column(children: [
                    Row(children: [
                      Image.asset(
                          'packages/nanny_components/assets/images/map/map_marker_user.png',
                          height: 24,
                          width: 24),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(
                        e.from ?? '',
                        maxLines: null,
                        style: NannyTextStyles.nw40018,
                      ))
                    ]),
                    const SizedBox(height: 8),
                    Row(children: [
                      Image.asset(
                          'packages/nanny_components/assets/images/map/map_marker_loc.png',
                          height: 24,
                          width: 24),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(e.to ?? '',
                              maxLines: null, style: NannyTextStyles.nw40018))
                    ])
                  ]))
              .toList()),
    );
  }

  Widget placeholderImg() =>
      Image.network('packages/nanny_components/assets/images/map/car.png',
          height: 100, width: 164);

  Widget tariffInfo() {
    var img = Reorderable.currentTariff?.photoPath;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        height: 160,
        width: double.infinity,
        child: Stack(children: [
          Positioned(
              left: 0,
              bottom: 4,
              child: img != null
                  ? SizedBox(
                      width: 164,
                      height: 103,
                      child: RotatedBox(
                          quarterTurns: 1,
                          child:
                              NetImage(url: img, radius: 0, fit: BoxFit.cover)))
                  : placeholderImg()),
          Positioned(
              top: 16,
              right: 14,
              child: Text(
                '${order.amount?.toStringAsFixed(1) ?? ''} ₽',
                style: NannyTextStyles.nw40018.copyWith(fontSize: 30),
              )),
          Positioned(
              top: 54,
              right: 24,
              child: Text(
                '${Reorderable.orderDuration.ceil()} мин',
                style: NannyTextStyles.nw60024.copyWith(fontSize: 16),
              ))
        ]));
  }
}
class Reorderable {
  static DriveTariff? currentTariff;
  static double orderDuration = 0;
}
