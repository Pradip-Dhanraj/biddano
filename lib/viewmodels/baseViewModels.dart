import 'dart:async';

import 'package:biddano/services/http-services.dart';
import 'package:biddano/utils/locator.dart';
import 'package:biddano/utils/navigation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;
  late NavigationService navigationService;
  late HttpServices http;
  late StreamSubscription<ConnectivityResult> subscription;

  bool _isConnected = false;
  bool get isConnected => _isConnected;
  set isConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  BaseViewModel() {
    navigationService = locator<NavigationService>();
    http = locator<HttpServices>();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      isConnected = result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile;
    });
    checkConnection();
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    isConnected = connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile;
  }
}
