import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GenerateCsvOptions extends StatefulWidget {
  final Function returnListCallback;

  GenerateCsvOptions(this.returnListCallback);

  @override
  _GenerateCsvOptionsState createState() => _GenerateCsvOptionsState();
}

class _GenerateCsvOptionsState extends State<GenerateCsvOptions> {
  List<int> chosenGenerateOptions = [];

  changeValueInList(int chosenOptionCode) {
    setState(() {
      if (chosenGenerateOptions.contains(chosenOptionCode)) {
        chosenGenerateOptions.remove(chosenOptionCode);
      } else {
        chosenGenerateOptions.add(chosenOptionCode);
      }
    });
    widget.returnListCallback(chosenGenerateOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(11.0),
      child: Container(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            RaisedButton.icon(
              onPressed: () {
                changeValueInList(1);
              },
              label: Text('Minimum'),
              icon: chosenGenerateOptions.contains(1)
                  ? Icon(Icons.remove)
                  : Icon(Icons.add),
            ),
            RaisedButton.icon(
              onPressed: () {
                changeValueInList(2);
              },
              label: Text('Srednia'),
              icon: chosenGenerateOptions.contains(2)
                  ? Icon(Icons.remove)
                  : Icon(Icons.add),
            ),
            RaisedButton.icon(
              onPressed: () {
                changeValueInList(3);
              },
              label: Text('Mediana'),
              icon: chosenGenerateOptions.contains(3)
                  ? Icon(Icons.remove)
                  : Icon(Icons.add),
            ),
            RaisedButton.icon(
              onPressed: () {
                changeValueInList(4);
              },
              label: Text('Maksimum'),
              icon: chosenGenerateOptions.contains(4)
                  ? Icon(Icons.remove)
                  : Icon(Icons.add),
            ),
            RaisedButton.icon(
              onPressed: () {
                changeValueInList(5);
              },
              label: Text('Całkowita cena'),
              icon: chosenGenerateOptions.contains(5)
                  ? Icon(Icons.remove)
                  : Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
