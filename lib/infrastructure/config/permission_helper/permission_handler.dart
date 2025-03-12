import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/function/helper.dart';

class PermissionHandler {
  final Logger _logger = Logger();

  void init() async {
    await requestNotificationPermission();
    await requestLocationPermission();
    // await requestLocationAlwaysPermission();
    await requestStoragePermission();
    await requestCameraPermission();
  }

  /// Method umum untuk meminta izin dan menangani error
  Future<bool> _requestPermission(Permission permission, String permissionName) async {
    try {
      PermissionStatus status = await permission.status;

      if (status.isGranted) {
        _logger.i('Izin $permissionName sudah diberikan');
        return true;
      } else if (status.isDenied) {
        status = await permission.request();
        if (status.isGranted) {
          _logger.i('Izin $permissionName diberikan setelah permintaan');
          return true;
        } else {
          _logger.w('Izin $permissionName ditolak');
          // _showToast('Izin $permissionName ditolak. Beberapa fitur mungkin tidak berfungsi.');
          return false;
        }
      } else if (status.isPermanentlyDenied) {
        _logger.w('Izin $permissionName ditolak secara permanen');
        // _showToast(
        //     'Izin $permissionName ditolak secara permanen. Buka pengaturan untuk mengaktifkannya.');
        Helper().openSettings(
          label: permissionName,
          message: 'Izin $permissionName diperlukan untuk fitur tertentu',
          afterCreateUpdate: () async {
            await openAppSettings().then((value) {
              _logger.i('openAppSettings value: $value');
            });
          },
        );
        return false;
      }
    } catch (e) {
      _logger.e('Error saat meminta izin $permissionName: $e');
      // _showToast('Terjadi kesalahan saat meminta izin $permissionName.');
    }

    return false;
  }

  /// Meminta izin notifikasi
  Future<bool> requestNotificationPermission() async {
    return _requestPermission(Permission.notification, 'Notifikasi');
  }

  // /// Meminta izin lokasi (hanya saat digunakan)
  // Future<bool> requestLocationPermission() async {
  //   return _requestPermission(Permission.location, 'Lokasi');
  // }
  /// Meminta izin lokasi (hanya saat digunakan)
  Future<bool> requestLocationPermission() async {
    return _requestPermission(Permission.locationWhenInUse, 'Lokasi');
  }

  // /// Meminta izin lokasi (selalu)
  // Future<bool> requestLocationAlwaysPermission() async {
  //   return _requestPermission(Permission.locationAlways, 'Lokasi (Selalu)');
  // }

  /// Meminta izin penyimpanan (gallery)
  Future<bool> requestStoragePermission() async {
    return _requestPermission(Permission.storage, 'Penyimpanan');
  }

  /// Meminta izin kamera
  Future<bool> requestCameraPermission() async {
    return _requestPermission(Permission.camera, 'Kamera');
  }
}
