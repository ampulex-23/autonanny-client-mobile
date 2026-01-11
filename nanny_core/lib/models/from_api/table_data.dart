class NannyTableData {
  const NannyTableData({
    required this.value,
    required this.title,
    required this.description,
  });

  final int value;
  final String title;
  final String description;

  NannyTableData.fromJson(Map<String, dynamic> json)
    : value = json["vallue"],
      title = json["title"],
      description = json["description"];
}