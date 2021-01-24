import 'package:flutter/material.dart';

class ChooseColumns extends StatefulWidget {
  final List<List<dynamic>> dynamicListFromCsvFile;
  final Function chosenColumnCallback;
  final bool returnMoreThanOne;

  final String mainDescription;

  ChooseColumns(this.dynamicListFromCsvFile, this.chosenColumnCallback,
      this.mainDescription, {this.returnMoreThanOne = false});

  @override
  _ChooseColumnsState createState() => _ChooseColumnsState();
}

class _ChooseColumnsState extends State<ChooseColumns> {
  List<int> nameIndexList = [];
  List<String> nameNameList = [];
  int singleIndex;


  nameIndexListCallback(List<int> indexList) {
    nameIndexList = indexList;
  }

  addNameIndexToList(int index) {
    setState(() {
      nameIndexList.add(index);
      nameNameList.add(widget.dynamicListFromCsvFile[0][index]);
    });
  }

  removeNameIndexFromList(int index) {
    setState(() {
      nameIndexList.remove(index);
      nameNameList.remove(widget.dynamicListFromCsvFile[0][index]);
    });
  }

  changePriceIndex(int index) {
    setState(() {
      nameIndexList.add(index);
      nameNameList.add(widget.dynamicListFromCsvFile[0][index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Text(widget.mainDescription)),
        if (nameNameList.isNotEmpty)
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(child: Text(
                      widget.returnMoreThanOne ? 'Wybrane: ' : 'Wybrany: ' +
                          nameNameList.toString())),
                  Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          widget.returnMoreThanOne ? widget.chosenColumnCallback(nameIndexList) : widget.chosenColumnCallback(singleIndex);
                        },
                        child: Text('Potweirdzam wybór i przechodzę dalej'),
                      ))
                ],
              )),
        Expanded(
            flex: 8,
            child: widget.returnMoreThanOne ? ListView.builder(
                itemCount: widget.dynamicListFromCsvFile[0].length,
                itemBuilder: (context, index) {
                  return !nameIndexList.contains(index)
                      ? RaisedButton.icon(
                      onPressed: () {
                        addNameIndexToList(index);
                      },
                      icon: Icon(Icons.add),
                      label: Text(widget.dynamicListFromCsvFile[0][index]))
                      : RaisedButton.icon(
                      onPressed: () {
                        removeNameIndexFromList(index);
                      },
                      icon: Icon(Icons.remove),
                      label: Text(widget.dynamicListFromCsvFile[0][index]));
                }) : ListView.builder(
                itemCount: widget.dynamicListFromCsvFile[0].length,
                itemBuilder: (context, index) {
                  return singleIndex == index
                      ? RaisedButton(
                    onPressed: () {},
                    child: Text(widget.dynamicListFromCsvFile[0][index]),
                  )
                      : RaisedButton.icon(
                      onPressed: () {
                        changePriceIndex(index);
                      },
                      icon: Icon(Icons.add),
                      label: Text(widget.dynamicListFromCsvFile[0][index]));
                }),
        )
      ],
    );
  }
}
