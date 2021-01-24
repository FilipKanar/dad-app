import 'package:flutter/material.dart';
import 'package:tata_app/wrapper/permission_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tata apka',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: StoragePermissionWrapper(),
    );
  }
}

