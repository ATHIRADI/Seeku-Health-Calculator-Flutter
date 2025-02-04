import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/providers/language_provider.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => LanguageSelectorState();
}

class LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<Locale>(
        value: languageProvider.currentLocale,
        dropdownColor: Theme.of(context).cardColor,
        style: Theme.of(context).textTheme.bodyLarge,
        underline: const SizedBox(),
        items: [
          _buildLanguageDropdownItem(context, const Locale('en'), 'Eng'),
          _buildLanguageDropdownItem(context, const Locale('es'), 'Esp'),
          _buildLanguageDropdownItem(context, const Locale('zh'), 'Chi'),
          _buildLanguageDropdownItem(context, const Locale('hi'), 'Hin'),
          _buildLanguageDropdownItem(context, const Locale('ar'), 'Ara'),
          _buildLanguageDropdownItem(context, const Locale('fr'), 'Fra'),
          _buildLanguageDropdownItem(context, const Locale('pt'), 'Por'),
          _buildLanguageDropdownItem(context, const Locale('ru'), 'Rus'),
          _buildLanguageDropdownItem(context, const Locale('de'), 'Ger'),
          _buildLanguageDropdownItem(context, const Locale('ja'), 'Jap'),
          _buildLanguageDropdownItem(context, const Locale('ko'), 'Kor'),
        ],
        onChanged: (locale) async {
          if (locale != null) {
            languageProvider.setLanguage(locale);
            // Reload the selected locale
            await S.load(locale);
          }
        },
        isExpanded: false,
        hint: Text(
          S.of(context).selectLanguageLabel,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).iconTheme.color?.withOpacity(0.7),
              ),
        ),
      ),
    );
  }

  DropdownMenuItem<Locale> _buildLanguageDropdownItem(
    BuildContext context,
    Locale locale,
    String languageName,
  ) {
    return DropdownMenuItem<Locale>(
      value: locale,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          languageName,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).iconTheme.color,
              ),
        ),
      ),
    );
  }
}
