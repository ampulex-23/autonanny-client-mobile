/// Утилита для фильтрации нецензурных слов в сообщениях
/// FE-MVP-024: Клиентская фильтрация нецензурных слов в чатах
class ProfanityFilter {
  // Список нецензурных слов (базовый набор)
  static final List<String> _profanityWords = [
    // Мат и грубые выражения
    'блять', 'бля', 'блядь', 'блядина', 'блядство',
    'ебать', 'ебал', 'ебаный', 'ебанутый', 'ебло', 'ебать',
    'хуй', 'хуя', 'хуйня', 'хуёво', 'хуевый', 'хуета',
    'пизда', 'пиздец', 'пиздить', 'пиздюк', 'пиздеть',
    'сука', 'суки', 'сучка', 'сучий',
    'мудак', 'мудила', 'мудачок', 'мудачина',
    'гандон', 'гондон',
    'долбоёб', 'долбаёб',
    'уёбок', 'уебок', 'уебище',
    'пидор', 'пидорас', 'пидорасина',
    'шлюха', 'шлюшка',
    'дерьмо', 'говно', 'говнюк',
    'жопа', 'жопный',
    'ссать', 'ссаный',
    'срать', 'сраный',
    
    // Варианты с заменой букв
    'бл@ть', 'бл*ть', 'бл#ть',
    'еб@ть', 'еб*ть', 'еб#ть',
    'х@й', 'х*й', 'х#й',
    'п@зда', 'п*зда', 'п#зда',
    'с@ка', 'с*ка', 'с#ка',
    
    // Транслит
    'blyat', 'blya', 'blyad',
    'ebat', 'ebal', 'ebany',
    'hui', 'huya', 'huynya',
    'pizda', 'pizdec',
    'suka', 'suchka',
    'mudak', 'mudila',
  ];

  /// Проверяет, содержит ли текст нецензурные слова
  static bool containsProfanity(String text) {
    if (text.trim().isEmpty) return false;
    
    final lowerText = text.toLowerCase();
    
    for (final word in _profanityWords) {
      // Проверяем точное совпадение слова с учетом границ слов
      final pattern = RegExp(r'\b' + RegExp.escape(word) + r'\b', caseSensitive: false);
      if (pattern.hasMatch(lowerText)) {
        return true;
      }
      
      // Проверяем вхождение в слово (для коротких слов)
      if (word.length >= 4 && lowerText.contains(word)) {
        return true;
      }
    }
    
    return false;
  }

  /// Фильтрует нецензурные слова, заменяя их на "***"
  static String filterProfanity(String text) {
    if (text.trim().isEmpty) return text;
    
    String filteredText = text;
    
    for (final word in _profanityWords) {
      // Заменяем с учетом границ слов
      final pattern = RegExp(r'\b' + RegExp.escape(word) + r'\b', caseSensitive: false);
      filteredText = filteredText.replaceAllMapped(pattern, (match) => '***');
      
      // Заменяем вхождения в слова (для коротких слов)
      if (word.length >= 4) {
        final containsPattern = RegExp(RegExp.escape(word), caseSensitive: false);
        filteredText = filteredText.replaceAllMapped(containsPattern, (match) => '***');
      }
    }
    
    return filteredText;
  }

  /// Результат проверки текста на нецензурность
  static ProfanityCheckResult checkText(String text) {
    final hasProfanity = containsProfanity(text);
    final filteredText = hasProfanity ? filterProfanity(text) : text;
    
    return ProfanityCheckResult(
      originalText: text,
      filteredText: filteredText,
      hasProfanity: hasProfanity,
    );
  }
}

/// Результат проверки текста на нецензурность
class ProfanityCheckResult {
  final String originalText;
  final String filteredText;
  final bool hasProfanity;

  ProfanityCheckResult({
    required this.originalText,
    required this.filteredText,
    required this.hasProfanity,
  });
}
