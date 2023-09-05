import 'package:e_jareemah/App/Services/PermissionService/permission_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../AuthenticationService/Core/manager.dart';

class HandlerPermissionService implements PermissionsService {
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  @override
  Future<Map<Permission, PermissionStatus>> requestAllMediaPermissions() async {
    Map<Permission, PermissionStatus> allMediaPermissionStatus = await [
      Permission.camera,
      Permission.photos,
      Permission.microphone,
      Permission.storage,
    ].request();
    return allMediaPermissionStatus;
  }

  @override
  Future<Map<Permission, PermissionStatus>> requestLocationPermission() async {
    Map<Permission, PermissionStatus> locationPermissionStatus = await [
      Permission.locationWhenInUse,
    ].request();
    return locationPermissionStatus;
    // Permission.location,
    // Permission.locationAlways,
  }

  @override
  Future<bool> handleCameraPermission() async {
    PermissionStatus cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus != PermissionStatus.granted) {
      // appTools.showTaxiPerrySnackBarWithAction(
      //     'permissionCameraFailed'.tr, 'openSettings'.tr, openAppSettings);

      return false;
    }
    return true;
  }

  @override
  Future<bool> handlePhotosPermission() async {
    PermissionStatus photosPermissionStatus = await requestPhotosPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      appTools.showJareemahSnackBarWithAction(
          'لم يتم الحصول على صلاحية الوصول للصور',
          'فتح الاعدادات',
          openAppSettings);

      return false;
    }
    return true;
  }

  @override
  Future<bool> handleAllMediaPermission() async {
    Map<Permission, PermissionStatus> allMediaPermissionStatus =
        await requestAllMediaPermissions();

    bool result = true;

    allMediaPermissionStatus.forEach((key, value) {
      if (value != PermissionStatus.granted) result = false;
    });

    if (result != true) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> handleLocationPermission() async {
    Map<Permission, PermissionStatus> locationPermission =
        await requestLocationPermission();

    bool result = true;

    locationPermission.forEach((key, value) {
      if (value != PermissionStatus.granted) result = false;
    });

    if (result != true) {
      // appTools.showTaxiPerrySnackBarWithAction(
      //     'permissionLocationFailed'.tr, 'openSettings'.tr, openAppSettings);
      return false;
    }

    return true;
  }
}
