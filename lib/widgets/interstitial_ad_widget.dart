import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:seeku_health_calc/utils/ad_utils.dart';

class InterstitialAdWidget {
  InterstitialAd? _interstitialAd;

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdUtils.interstitialAdUnit, // Replace with your ad unit ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              loadInterstitialAd(); // Load a new ad for the next time
            },
          );
          print("Interstitial ad loaded successfully.");
        },
        onAdFailedToLoad: (err) {
          print("Failed to load an interstitial ad: ${err.message}");
        },
      ),
    );
  }

  void showAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      print("Interstitial ad is not ready yet.");
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
