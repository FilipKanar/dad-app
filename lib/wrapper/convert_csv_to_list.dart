import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tata_app/UI/options/shared/choose_columns.dart';
import 'package:tata_app/service/file/file_service.dart';

class ConvertCsvToList extends StatefulWidget {
  final File csvFile;
  ConvertCsvToList(this.csvFile);
  @override
  _ConvertCsvListState createState() => _ConvertCsvListState();
}

class _ConvertCsvListState extends State<ConvertCsvToList> {

  testMethod(List<int> list) {
    print('Lista: ' + list.toString());
  }
  testMethod2(int a) {
    print('Lista: ' + a.toString());
  }

  @override
  Widget build(BuildContext context) {
    return widget.csvFile == null
        ? Center(child: Text('No file provided'),)
        : FutureBuilder(
        future: FileService().convertCsvToDynamicList(widget.csvFile),
        builder: (context, value) {
          return ChooseColumns(value.data, testMethod, 'Wybierz cene', returnMoreThanOne: true,);//ChooseUniqueName(value.data);
        });
  }
}
