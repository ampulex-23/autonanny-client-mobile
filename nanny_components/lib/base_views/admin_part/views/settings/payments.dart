import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';

class PaymentsSettingsView extends StatefulWidget {
  const PaymentsSettingsView({super.key});

  @override
  State<PaymentsSettingsView> createState() => _PaymentsSettingsViewState();
}

class _PaymentsSettingsViewState extends State<PaymentsSettingsView> {
  List<String> payments = [
    "Мир",
    "MasterCard",
    "Visa",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const NannyAppBar(
          title: "Оплата",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Способы оплаты", style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 10),
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: payments.map(
                    (e) => ListTile(
                      title: Text(e, style: Theme.of(context).textTheme.labelLarge),
                    )
                  ).toList()
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}