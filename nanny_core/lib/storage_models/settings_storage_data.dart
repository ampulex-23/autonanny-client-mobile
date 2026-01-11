import 'package:nanny_core/storage_models/base_storage.dart';

class SettingsStorageData implements BaseStorage {
  SettingsStorageData({
    required this.useBiometrics
  });

  final bool useBiometrics;
  
  @override
  Map<String, dynamic> toJson() => {
    "useBiometrics": useBiometrics,
  };

  SettingsStorageData.fromJson(Map<String, dynamic> json)
    : useBiometrics = json['useBiometrics'] ?? false;
}