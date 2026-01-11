import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/models/from_api/drive_and_map/schedule.dart';

import 'package:nanny_core/models/order.dart';
import 'package:nanny_core/nanny_globals.dart';

import 'details_widget.dart';
import 'enter_new_name_widget.dart';
import 'graph_change_widget.dart';

class BaseBottomSheet {
  static Future<bool> showDetails(Order order) async {
    var result = await _showModalControlled(DetailsWidget(order),
        cancellable: true, padding: EdgeInsets.zero);
    if (result == true) {
      return true;
    }
    return false;
  }

  static BuildContext? getContext() =>
      NannyGlobals.navKey.currentState?.context;

  static Future<bool> showChangeGraph(Road road, int scheduleId) async {
    var result =
        await _showModalControlled(GraphChangeWidget(road, scheduleId));
    if (result is Road) {

      return true;
    }
    return false;
  }

  static Future<String> showChangeNameGraph(String prev) async {
    var result = await _showModalControlled(EnterNewNameWidget(prev));
    if (result is String) {
      return result;
    }
    return prev;
  }

  static Future<dynamic> _showModal(Widget child,
      {BuildContext? currentContext,
      double sizeMultiplier = 0.85,
      bool cancellable = false}) async {
    final context = currentContext ?? getContext();
    if (context != null) {
      return showModalBottomSheet(
          context: context,
          isDismissible: cancellable,
          isScrollControlled: true,
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height * sizeMultiplier,
              minHeight: MediaQuery.of(context).size.height * sizeMultiplier),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16))),
          builder: (context) {
            return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16))),
                child: child);
          });
    }
  }

  static Future<dynamic> _showModalControlled(Widget child,
      {BuildContext? currentContext,
      bool cancellable = false,
      EdgeInsets? padding}) async {
    final context = currentContext ?? getContext();
    if (context != null) {
      return showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          isDismissible: cancellable,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16))),
          builder: (context) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(children: [
                  Container(
                      padding: padding ?? const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(247, 247, 247, 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16))),
                      child: child)
                ]));
          });
    }
  }
}
