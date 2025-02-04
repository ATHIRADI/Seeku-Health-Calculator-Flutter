import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/utils/providers/bac_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/blood_donation_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/blood_pressure_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/blood_volume_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/bmi_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/body_fat_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/breath_count_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/calories_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/heart_rate_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/ideal_weight_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/ovulation_period_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/pregnancy_due_date_result_provider.dart';
import 'package:seeku_health_calc/utils/providers/theme_provider.dart';
import 'package:seeku_health_calc/utils/routes/app_routes.dart';
import 'package:seeku_health_calc/utils/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/providers/language_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => BMIResultProvider()),
        ChangeNotifierProvider(
            create: (context) => IdealWeightResultProvider()),
        ChangeNotifierProvider(create: (context) => BodyFatResultProvider()),
        ChangeNotifierProvider(create: (context) => CaloriesResultProvider()),
        ChangeNotifierProvider(create: (context) => HeartRateResultProvider()),
        ChangeNotifierProvider(
            create: (context) => PregnancyDueDateResultProvider()),
        ChangeNotifierProvider(
            create: (context) => OvulationPeriodResultProvider()),
        ChangeNotifierProvider(
            create: (context) => BloodVolumeResultProvider()),
        ChangeNotifierProvider(
            create: (context) => BloodDonationResultProvider()),
        ChangeNotifierProvider(create: (context) => BACResultProvider()),
        ChangeNotifierProvider(
            create: (context) => BloodPressureResultProvider()),
        ChangeNotifierProvider(
            create: (context) => BreathCountResultProvider()),
      ],
      child: const MyBMICalculatorApp(),
    ),
  );
}

class MyBMICalculatorApp extends StatelessWidget {
  const MyBMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          title: 'Complete Health Calculator App.',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.isDarkMode
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,

          // darkTheme: AppTheme.darkTheme,
          // themeMode: ThemeMode.system,
          locale: languageProvider.currentLocale,
          supportedLocales: languageProvider.getSupportedLocales(),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: AppRoutes.intro,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
