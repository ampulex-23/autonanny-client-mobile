import 'package:flutter/material.dart';
import 'package:nanny_client/view_models/map/drive_search_vm.dart';
import 'package:nanny_components/nanny_components.dart';

class DriverSearchView extends StatefulWidget {
  const DriverSearchView({super.key, required this.token});

  final String token;

  @override
  State<DriverSearchView> createState() => _DriverSearchViewState();
}

class _DriverSearchViewState extends State<DriverSearchView> {
  late DriveSearchVM vm;

  @override
  void initState() {
    super.initState();
    vm = DriveSearchVM(
      context: context,
      update: setState,
      token: widget.token,
    );
  }

  @override
  void dispose() {
    super.dispose();
    vm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureLoader(
      future: vm.loadRequest,
      completeView: (context, data) {
        if (!data) {
          return const ErrorView(errorText: "Не удалось загрузить данные!");
        }

        return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Text("Поиск водителя..."),
              const SizedBox(height: 10),
              const LinearProgressIndicator(),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Отменить"))
            ]));
      },
      errorView: (context, error) => ErrorView(errorText: error.toString()),
    );
  }
}
