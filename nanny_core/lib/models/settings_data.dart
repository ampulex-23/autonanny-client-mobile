class SettingsData<T> {
  SettingsData({
    required this.name,
    required this.enabled,
    this.addition,
  });

  final String name;
  bool enabled;
  T? addition;
}