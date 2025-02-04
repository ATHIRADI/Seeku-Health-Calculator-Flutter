import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart'; // Import localization
import 'package:seeku_health_calc/utils/providers/theme_provider.dart';
import 'package:seeku_health_calc/widgets/language_selector.dart';
import 'home_screen.dart';
import 'package:seeku_health_calc/utils/screen_util.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/settings_option.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context); // Get localization instance
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Get theme provider

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.appBarTitleMain), // Use localized title
      ),
      drawer: SizedBox(
        width: 380,
        child: Drawer(
          child: _buildDrawerContent(
              context, localization, themeProvider), // Pass localization
        ),
      ),
      body: const HomeScreen(),
    );
  }

  Widget _buildDrawerContent(
      BuildContext context, S localization, ThemeProvider themeProvider) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    localization.drawerHeader, // Use localized header
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableBgCard(
                  heightFactor: null,
                  cardChild: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: Theme.of(context).iconTheme.color,
                            size: ScreenUtil.responsiveFontSize(
                              context,
                              mobile: 28,
                              tablet: 38,
                              desktop: 48,
                            ),
                            semanticLabel: 'Language Icon',
                          ),
                          Spacing.mediumHorizontal,
                          AdaptiveText(
                            localization
                                .language, // Use localized language label
                            mobileSize: 16,
                            tabletSize: 18,
                            desktopSize: 20,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Spacer(),
                          LanguageSelector(),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacing.mediumVertical,
                ReusableBgCard(
                  heightFactor: null,
                  cardChild: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.dark_mode,
                            color: Theme.of(context).iconTheme.color,
                            size: ScreenUtil.responsiveFontSize(
                              context,
                              mobile: 28,
                              tablet: 38,
                              desktop: 48,
                            ),
                          ),
                          Spacing.mediumHorizontal,
                          AdaptiveText(
                            S.of(context).darkMode,
                            mobileSize: 16,
                            tabletSize: 18,
                            desktopSize: 20,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Spacer(),
                          Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.toggleTheme(); // Toggle the theme
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacing.mediumVertical,
                SettingsOption(
                  title: localization.privacyPolicy, // Use localized title
                  icon: Icons.privacy_tip,
                  onTap: () {
                    // Handle privacy policy tap
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text(localization
                                .privacyPolicy), // Use localized title
                          ),
                          body: const Center(
                            child: Text('Privacy Policy Details'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Spacing.mediumVertical,
                SettingsOption(
                  title: localization.share, // Use localized title
                  icon: Icons.share,
                  onTap: () {
                    // Handle share tap
                  },
                ),
                Spacing.mediumVertical,
                SettingsOption(
                  title: localization.rateUs, // Use localized title
                  icon: Icons.star,
                  onTap: () {
                    // Handle rate us tap
                  },
                ),
                Spacing.mediumVertical,
                SettingsOption(
                  title: localization.feedback, // Use localized title
                  icon: Icons.feedback,
                  onTap: () {
                    // Handle feedback tap
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
