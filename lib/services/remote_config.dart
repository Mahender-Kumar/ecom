import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigService with ChangeNotifier {
  late FirebaseRemoteConfig _remoteConfig;
  bool showDiscountedPrice = false;

  RemoteConfigService() {
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    _remoteConfig = FirebaseRemoteConfig.instance;

    try {
      // Set default values
      await _remoteConfig.setDefaults(<String, dynamic>{
        'show_discounted_price': false,
      });

      // Set the minimum fetch interval to 10 seconds for development (set higher in production)
      _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10), // Timeout for fetching remote config
        minimumFetchInterval: const Duration(seconds: 10), // Minimum fetch interval
      ));

      // Fetch and activate the latest values
      await _remoteConfig.fetchAndActivate();

      // Get the latest value for 'show_discounted_price'
      showDiscountedPrice = _remoteConfig.getBool('show_discounted_price');

      notifyListeners(); // Notify listeners to update UI
    } catch (e) {
      print('Remote Config fetch failed: $e');
      // Handle any errors or fallback logic
    }
  }
}
