class NannyUtils {
  static String capitaliseWords(String text) {
    List<String> newText = [];
    for (var word in text.split(' ')) {
      newText.add(word[0].toUpperCase() + word.substring(1));
    }
    
    return newText.join(' ');
  }

  static List<int> retreiveDateParts(String date) {
    var parts = date.split('.');
    assert(
      parts.map((e) => int.tryParse(e))
        .toList()
        .where((e) => e == null)
        .isEmpty
    );

    return date.split('.')
      .map((e) => int.parse(e))
      .toList();
  }
}