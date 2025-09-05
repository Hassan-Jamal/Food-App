import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  String? _currentAddress;
  bool _isLoading = false;
  String? _errorMessage;
  bool _locationPermissionGranted = false;

  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get locationPermissionGranted => _locationPermissionGranted;

  double? get latitude => _currentPosition?.latitude;
  double? get longitude => _currentPosition?.longitude;

  Future<bool> requestLocationPermission() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final status = await Permission.location.request();
      _locationPermissionGranted = status.isGranted;

      if (_locationPermissionGranted) {
        await getCurrentLocation();
      } else {
        _errorMessage = 'Location permission denied';
      }

      return _locationPermissionGranted;
    } catch (e) {
      _errorMessage = 'Failed to request location permission: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getCurrentLocation() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _errorMessage = 'Location services are disabled';
        return false;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _errorMessage = 'Location permission denied';
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _errorMessage = 'Location permissions are permanently denied';
        return false;
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // Get address from coordinates
      await _getAddressFromPosition(_currentPosition!);

      _locationPermissionGranted = true;
      return true;
    } catch (e) {
      _errorMessage = 'Failed to get current location: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _currentAddress = _formatAddress(place);
      }
    } catch (e) {
      _errorMessage = 'Failed to get address: ${e.toString()}';
    }
  }

  String _formatAddress(Placemark place) {
    List<String> addressParts = [];

    if (place.street != null && place.street!.isNotEmpty) {
      addressParts.add(place.street!);
    }
    if (place.subLocality != null && place.subLocality!.isNotEmpty) {
      addressParts.add(place.subLocality!);
    }
    if (place.locality != null && place.locality!.isNotEmpty) {
      addressParts.add(place.locality!);
    }
    if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
      addressParts.add(place.administrativeArea!);
    }
    if (place.country != null && place.country!.isNotEmpty) {
      addressParts.add(place.country!);
    }

    return addressParts.join(', ');
  }

  Future<List<Placemark>> searchAddress(String query) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      List<Location> locations = await locationFromAddress(query);
      
      if (locations.isEmpty) {
        _errorMessage = 'No locations found for the given address';
        return [];
      }

      List<Placemark> placemarks = await placemarkFromCoordinates(
        locations.first.latitude,
        locations.first.longitude,
      );

      return placemarks;
    } catch (e) {
      _errorMessage = 'Failed to search address: ${e.toString()}';
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<double> calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    try {
      double distance = Geolocator.distanceBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      );

      return distance / 1000; // Convert to kilometers
    } catch (e) {
      _errorMessage = 'Failed to calculate distance: ${e.toString()}';
      return 0.0;
    }
  }

  Future<double> calculateDeliveryTime({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    try {
      double distance = await calculateDistance(
        startLatitude: startLatitude,
        startLongitude: startLongitude,
        endLatitude: endLatitude,
        endLongitude: endLongitude,
      );

      // Estimate delivery time based on distance
      // Assuming average speed of 30 km/h in city traffic
      double timeInHours = distance / 30.0;
      return timeInHours * 60; // Convert to minutes
    } catch (e) {
      _errorMessage = 'Failed to calculate delivery time: ${e.toString()}';
      return 30.0; // Default 30 minutes
    }
  }

  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      return false;
    }
  }

  Future<LocationPermission> checkLocationPermission() async {
    try {
      return await Geolocator.checkPermission();
    } catch (e) {
      return LocationPermission.denied;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void setCurrentPosition(Position position) {
    _currentPosition = position;
    _getAddressFromPosition(position);
    notifyListeners();
  }

  void setCurrentAddress(String address) {
    _currentAddress = address;
    notifyListeners();
  }
}
