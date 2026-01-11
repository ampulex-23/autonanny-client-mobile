import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/api/nanny_orders_api.dart';
import 'package:nanny_core/nanny_core.dart';

class DriverOrdersView extends StatefulWidget {
  const DriverOrdersView({super.key});

  @override
  State<DriverOrdersView> createState() => _DriverOrdersViewState();
}

class _DriverOrdersViewState extends State<DriverOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NannyAppBar(
        title: "Управление заказами",
        isTransparent: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: FloatingActionButton.large(
              onPressed: () => NannyDialogs.showRouteCreateOrEditSheet(
                  context, NannyWeekday.monday),
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(height: 10),
          const Text("Новый заказ",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
              child: NannyBottomSheet(
                  child: RequestListLoader(
            request: NannyOrdersApi.getSchedules(),
            tileTemplate: (context, e) => ListTile(
              title: Text(e.title),
              subtitle: Text(e.description),
            ),
            errorView: (context, error) =>
                ErrorView(errorText: error.toString()),
          )))
        ],
      ),
    );
  }
}
