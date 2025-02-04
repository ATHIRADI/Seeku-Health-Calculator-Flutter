import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdUtils {
  static String get bannerAdUnit {
    if (Platform.isAndroid) {
      return dotenv.env['ADMOB_BANNER_AD_UNIT_ID_ANDROID'] ?? '';
    } else if (Platform.isIOS) {
      return dotenv.env['ADMOB_BANNER_AD_UNIT_ID_IOS'] ?? '';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnit {
    if (Platform.isAndroid) {
      return dotenv.env['ADMOB_INTERSTITIAL_AD_UNIT_ID_ANDROID'] ?? '';
    } else if (Platform.isIOS) {
      return dotenv.env['ADMOB_INTERSTITIAL_AD_UNIT_ID_IOS'] ?? '';
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
