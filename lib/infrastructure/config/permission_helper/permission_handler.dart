import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  PermissionHandler();

  Future<bool> requestNotificationPermission() async {
    // Check notification permission status
    PermissionStatus status = await Permission.notification.status;

    if (status.isGranted) {
      // Permission is already granted
      return true;
    } else if (status.isDenied) {
      // Request permission from the user
      status = await Permission.notification.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      // Redirect the user to app settings to enable the permission manually
      openAppSettings().then((value) => print(value));
      return false;
    }

    return false;
  }

  Future<bool> requestNetworkPermission() async {
    // Check network permission status
    PermissionStatus status = await Permission.locationWhenInUse.status;

    if (status.isGranted) {
      // Permission is already granted
      return true;
    } else if (status.isDenied) {
      // Request permission from the user
      status = await Permission.locationWhenInUse.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      // Redirect the user to app settings to enable the permission manually
      openAppSettings().then((value) => print(value));
      return false;
    }

    return false;
  }
}
