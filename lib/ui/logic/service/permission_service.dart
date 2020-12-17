import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final PermissionHandler permissionHandler = PermissionHandler();

  Future<bool> _requestPermission({List<PermissionGroup> permission}) async {
    var result = await permissionHandler.requestPermissions(permission);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestRequiredPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(permission: [
      PermissionGroup.camera,
      PermissionGroup.location,
      PermissionGroup.locationAlways,
      PermissionGroup.locationWhenInUse,
      PermissionGroup.microphone,
    ]);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }
}
