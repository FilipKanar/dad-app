import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tata_app/service/file/file_service.dart';
import 'package:tata_app/wrapper/convert_csv_to_list.dart';

class CsvFilePicker extends StatefulWidget {
  @override
  _CsvFilePickerState createState() => _CsvFilePickerState();
}

class _CsvFilePickerState extends State<CsvFilePicker> {

  File csvFile;

  _platformFileToFile() async {
    String path = await FileService().awaitCsvFile().then((value) => value.path);
    print('Path CFP, _pFT, :' + path);
    setState(() {
      csvFile = File(path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: csvFile == null ? Center(
        child: RaisedButton(
          onPressed: (){
           _platformFileToFile();
          },
          child: Text('Wybierz plik CSV'),
        ),
      ) : SafeArea(child: ConvertCsvToList(csvFile)),
    );
  }
}
