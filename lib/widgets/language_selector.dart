import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  static const Map<String, String> languages = {
    'en': 'English 🇬🇧',
    'fr': 'Français 🇫🇷',
    'es': 'Español 🇪🇸',
    'de': 'Deutsch 🇩🇪',
    'ar': 'العربية 🇸🇦',
    'zh': '中文 🇨🇳',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: languages.entries.map((entry) {
        final isSelected = entry.key == selectedLanguage;
        return RadioListTile<String>(
          value: entry.key,
          groupValue: selectedLanguage,
          onChanged: (value) {
            if (value != null) onLanguageChanged(value);
          },
          title: Text(entry.value),
          selected: isSelected,
          activeColor: Theme.of(context).colorScheme.primary,
        );
      }).toList(),
    );
  }
}
