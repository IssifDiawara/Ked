import 'package:geolocator/geolocator.dart';

class GeoLocation {
  Future<Position> get geoLocation async => await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
