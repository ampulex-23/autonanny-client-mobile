import 'package:flutter/material.dart';
import 'package:nanny_components/nanny_components.dart';

class UpdatesSettingsView extends StatefulWidget {
  const UpdatesSettingsView({super.key});

  @override
  State<UpdatesSettingsView> createState() => _UpdatesSettingsViewState();
}

class _UpdatesSettingsViewState extends State<UpdatesSettingsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const NannyAppBar(
          title: "Обновления",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
                Row(
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset('packages/nanny_components/assets/images/icon.png', height: 80),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Версия 1.0", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("25 Мб"),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Обновления..."),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: const Text("Загрузить и установить")
                  ),
                ),
                const SizedBox(height: 50),
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}