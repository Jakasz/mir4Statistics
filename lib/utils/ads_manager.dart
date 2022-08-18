import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  RewardedAd? _rewardedAd;

  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: //"ca-app-pub-3940256099942544/5224354917",
        "ca-app-pub-1492289253182832/3207302325",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
        }));
  }

  void addAd(bool isRewardedAd) {
    if (isRewardedAd) {
      loadRewardedAd();
    }
  }

  void showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedAd ad) {},
          onAdDismissedFullScreenContent: (RewardedAd ad) {
            ad.dispose();
            loadRewardedAd();
          },
          onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
            ad.dispose();
            loadRewardedAd();
          });

      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        print("${reward.amount} ${reward.type}");
      });
    }
  }

  checkAd() {
    if (_rewardedAd == null) {
      return false;
    } else
      return true;
  }

  void disposeAd() {
    _rewardedAd?.dispose();
  }
}
