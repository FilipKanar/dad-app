import 'package:flutter/material.dart';
import 'package:tata_app/UI/csv_file_picker.dart';
import 'package:tata_app/service/permissions/storage_permission_service.dart';

class StoragePermissionWrapper extends StatefulWidget {
  @override
  _StoragePermissionWrapperState createState() => _StoragePermissionWrapperState();
}

class _StoragePermissionWrapperState extends State<StoragePermissionWrapper> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StoragePermissionService().awaitStoragePermissions(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return CsvFilePicker();
          } else {
            return Scaffold(
              body: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text('Nie udzieliles pozwolenia, udziel pozwolenia w ustawienich systemu i zrestartuj aplikację.'),

                ],),
              ),
            );
          }
        });;
  }
}
