import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

class FileService{

  Future<PlatformFile> awaitCsvFile() async {
    return await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
    ).then((value) => value.files.first);
  }


  Future<List<List<dynamic>>> convertCsvToDynamicList(File file) async  {
    final Stream<List> input = file.openRead();
    return await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter()).toList();
  }
}