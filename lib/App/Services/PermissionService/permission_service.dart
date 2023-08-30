abstract class PermissionsService {
  Future requestCameraPermission();
  Future<bool> handleCameraPermission();

  Future requestPhotosPermission();
  Future<bool> handlePhotosPermission();

  Future requestAllMediaPermissions();
  Future<bool> handleAllMediaPermission();

  Future requestLocationPermission();
  Future<bool> handleLocationPermission();
}
