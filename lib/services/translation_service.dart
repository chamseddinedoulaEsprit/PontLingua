class TranslationService {
  static final Map<String, Map<String, String>> _translations = {
    'Hello': {
      'en': 'Hello',
      'fr': 'Bonjour',
      'es': 'Hola',
      'de': 'Hallo',
      'ar': 'مرحبا',
      'zh': '你好',
    },
    'How are you?': {
      'en': 'How are you?',
      'fr': 'Comment allez-vous ?',
      'es': '¿Cómo estás?',
      'de': 'Wie geht es dir?',
      'ar': 'كيف حالك؟',
      'zh': '你好吗？',
    },
    'Good morning': {
      'en': 'Good morning',
      'fr': 'Bonjour',
      'es': 'Buenos días',
      'de': 'Guten Morgen',
      'ar': 'صباح الخير',
      'zh': '早上好',
    },
    'Thank you': {
      'en': 'Thank you',
      'fr': 'Merci',
      'es': 'Gracias',
      'de': 'Danke',
      'ar': 'شكرا',
      'zh': '谢谢',
    },
    'Yes': {
      'en': 'Yes',
      'fr': 'Oui',
      'es': 'Sí',
      'de': 'Ja',
      'ar': 'نعم',
      'zh': '是的',
    },
    'No': {
      'en': 'No',
      'fr': 'Non',
      'es': 'No',
      'de': 'Nein',
      'ar': 'لا',
      'zh': '不',
    },
    'See you later': {
      'en': 'See you later',
      'fr': 'À bientôt',
      'es': 'Hasta luego',
      'de': 'Bis später',
      'ar': 'أراك لاحقا',
      'zh': '待会见',
    },
  };

  static String translate(String text, String fromLang, String toLang) {
    if (fromLang == toLang) return text;
    
    for (final entry in _translations.entries) {
      if (entry.value[fromLang]?.toLowerCase() == text.toLowerCase()) {
        return entry.value[toLang] ?? _simulateTranslation(text, toLang);
      }
    }
    
    return _simulateTranslation(text, toLang);
  }

  static String _simulateTranslation(String text, String toLang) {
    final prefixes = {
      'en': '',
      'fr': '[FR] ',
      'es': '[ES] ',
      'de': '[DE] ',
      'ar': '[AR] ',
      'zh': '[ZH] ',
    };
    return '${prefixes[toLang] ?? ''}$text';
  }

  static Map<String, String> translateToAll(String text, String fromLang) {
    final result = <String, String>{};
    for (final lang in ['en', 'fr', 'es', 'de', 'ar', 'zh']) {
      result[lang] = translate(text, fromLang, lang);
    }
    return result;
  }
}
