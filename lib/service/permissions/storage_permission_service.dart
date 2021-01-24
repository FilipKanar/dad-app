import 'package:permission_handler/permission_handler.dart';

class StoragePermissionService {


  Future<bool> awaitStoragePermissions() async {
    try {
      PermissionStatus permission = await Permission.storage.status;
      if (permission != PermissionStatus.granted) {
        await Permission.storage.request();
        permission = await Permission.storage.status;
        return permission != PermissionStatus.granted ? false : true;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}