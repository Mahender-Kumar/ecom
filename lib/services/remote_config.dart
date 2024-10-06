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

    // Set default values
    await _remoteConfig.setDefaults(<String, dynamic>{
      'show_discounted_price': false,
    });

    // Fetch and activate
    await _remoteConfig.fetchAndActivate();
    showDiscountedPrice = _remoteConfig.getBool('show_discounted_price');

    notifyListeners();
  }
}
