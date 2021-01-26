import 'package:permission_handler/permission_handler.dart';

class StoragePermissionService {


  Future<bool> awaitStoragePermissions() async {
    try {
      PermissionStatus permission = await Permission.storage.status;
      if (permission.isUndetermined) {
        await Permission.storage.request();
        permission = await Permission.storage.status;
        return permission.isGranted ? true : false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}