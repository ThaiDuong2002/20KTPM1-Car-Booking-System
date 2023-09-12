import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Tracking extends ChangeNotifier{
  bool _isTracking = false;
  bool get isTracking => _isTracking;

  @override
  void dispose() {
    
    super.dispose();
  }
  
  LatLng? _currentPosition;
  get currentPosition => _currentPosition;
  set setCurrentPosition(LatLng? value){
    _currentPosition = value;
    notifyListeners();
  }
  void updateTracking(bool value){
    _isTracking = value;
    notifyListeners();
  }


}