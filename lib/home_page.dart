import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tata_app/show_tiles.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text;

  List<List<dynamic>> orders2 = [];


  _awaitFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    );
    if (result != null) {
      setState(() {
        PlatformFile file = result.files.first;
        _convertData2(File(file.path));
      });
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: awaitStoragePermissions(),
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return _generateMainView(context);
          } else {
            return Scaffold(
              body: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text('Nie udzieliles pozwolenia, zrestartuj aplikację. Albo udzieliles ale nie dziala.'),
                  Text(snapshot != null ? snapshot.data : 'Null'),
                ],),
              ),
            );
          }
        });
  }

  _generateMainView(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {
                  _awaitFile();
                },
                child: Text('Wybierz plik'),
                color: Colors.lightBlueAccent,
              ),
              orders2 == null || orders2.isEmpty
                  ? Text('Brak pliku')
                  : ShowTiles(orders2),
            ],
          ),
          ),)
    );
  }

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


  _convertData2(File file) async  {
    final Stream<List> input = file.openRead();
    List<List<dynamic>> list = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter()).toList();
    setState(() {
      orders2=list;
    });
  }
}
