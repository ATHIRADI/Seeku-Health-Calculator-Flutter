import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageCodeKey = 'language_code';
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  LanguageProvider() {
    _loadLanguageFromPrefs();
  }

  Future<void> _loadLanguageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString(_languageCodeKey);

    if (savedLanguageCode != null) {
      _currentLocale = Locale(savedLanguageCode);
      notifyListeners();
    }
  }

  Future<void> setLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, locale.languageCode);

    _currentLocale = locale;
    notifyListeners();
  }

  List<Locale> getSupportedLocales() {
    return [
      const Locale('en'), // English
      const Locale('es'), // Español
      const Locale('pt'), // Português
      const Locale('fr'), // Français
      const Locale('de'), // Deutsch
      const Locale('zh'), // 中文
      const Locale('ru'), // Русский
      const Locale('ja'), // 日本語
      const Locale('ko'), // 한국어
      const Locale('it'), // Italiano
      const Locale('tr'), // Türkçe
      const Locale('id'), // Bahasa Indonesia
      const Locale('pl'), // Polski
      const Locale('ar'), // العربية
      const Locale('hi'), // हिन्दी
      const Locale('sq'), // Shqip
      const Locale('az'), // Azərbaycanca
      const Locale('bn'), // বাংলা
      const Locale('my'), // မြန်မာ
      const Locale('hr'), // Hrvatski
      const Locale('cs'), // Čeština
      const Locale('nl'), // Nederlands
      const Locale('el'), // Ελληνικά
      const Locale('gu'), // ગુજરાતી
      const Locale('hu'), // Magyar
      const Locale('kn'), // ಕನ್ನಡ
      const Locale('ml'), // മലയാളം
      const Locale('mr'), // मराठी
      const Locale('no'), // Norsk
      const Locale('or'), // ଓଡ଼ିଆ
      const Locale('fa'), // فارسی
      const Locale('pa'), // ਪੰਜਾਬੀ
      const Locale('ro'), // Română
      const Locale('sv'), // Svenska
      const Locale('ta'), // தமிழ்
      const Locale('te'), // తెలుగు
      const Locale('th'), // ไทย
      const Locale('uk'), // Українська
      const Locale('ur'), // اردو
      const Locale('vi'), // Tiếng Việt
    ];
  }
}
