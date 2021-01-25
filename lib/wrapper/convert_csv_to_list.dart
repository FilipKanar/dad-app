import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tata_app/UI/screens/user_choice.dart';
import 'package:tata_app/service/file/file_service.dart';

class ConvertCsvToList extends StatefulWidget {
  final File csvFile;
  ConvertCsvToList(this.csvFile);
  @override
  _ConvertCsvListState createState() => _ConvertCsvListState();
}

class _ConvertCsvListState extends State<ConvertCsvToList> {


  @override
  Widget build(BuildContext context) {
    return widget.csvFile == null
        ? Center(child: Text('No file provided'),)
        : FutureBuilder(
        future: FileService().convertCsvToDynamicList(widget.csvFile),
        builder: (context, value) {
          return UserChoice(value.data);//ChooseUniqueName(value.data);
        });
  }
}
