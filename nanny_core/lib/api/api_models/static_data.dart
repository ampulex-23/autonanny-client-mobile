class StaticData {
  StaticData({
    this.id = -1,
    this.title = "",
  });

  final int id;
  final String title;

  StaticData.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'];

  String toGetQuery() {
    if(id < 0 && title.isEmpty) return "";
    
    if(id > 0 && title.isEmpty) return "?id=$id";
    if(id < 0 && title.isNotEmpty) return "?title=$title";

    return "?id=$id&title=$title";
  }
}