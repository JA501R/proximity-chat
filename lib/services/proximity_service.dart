import 'package:flutter/foundation.dart';

class ProximityService extends ChangeNotifier {
  bool _isNearby = true;

  bool get isNearby => _isNearby;

  void setNearby(bool value) {
    if (_isNearby == value) {
      return;
    }

    _isNearby = value;
    notifyListeners();
  }

  void toggleForDevelopment() {
    setNearby(!_isNearby);
  }
}
