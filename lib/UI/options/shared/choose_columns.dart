import 'dart:math';

import 'package:flutter/material.dart';

class ChooseColumns extends StatefulWidget {
  final List<List<dynamic>> dynamicListFromCsvFile;
  final Function chosenColumnCallback;
  final bool returnMoreThanOne;

  final String mainDescription;

  ChooseColumns(this.dynamicListFromCsvFile, this.chosenColumnCallback,
      this.mainDescription,
      {this.returnMoreThanOne = false});

  @override
  _ChooseColumnsState createState() => _ChooseColumnsState();
}

class _ChooseColumnsState extends State<ChooseColumns> {
  List<int> nameIndexList = [];
  List<String> nameNameList = [];
  int singleIndex;

  clearData() {
    setState(() {
      nameIndexList.clear();
      nameNameList.clear();
      singleIndex = null;
    });
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
      singleIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Column(
        children: [
          Expanded(flex: 1, child: Text(widget.mainDescription)),
          if (nameNameList.isNotEmpty || singleIndex != null)
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(widget.returnMoreThanOne
                              ? 'Wybrane: '
                              : 'Wybrany: '),
                          nameNameList.isNotEmpty
                              ? Text(nameNameList.toString())
                              : Container(),
                          singleIndex != null
                              ? Text(singleIndex.toString())
                              : Container(),
                        ],
                      ),
                    )),
                    Expanded(
                        child: RaisedButton(
                      onPressed: () {
                        print('value bool: '+ widget.returnMoreThanOne.toString());
                        widget.returnMoreThanOne
                            ? widget.chosenColumnCallback(nameIndexList)
                            : widget.chosenColumnCallback(singleIndex);
                        clearData();
                      },
                      child: Text('Potweirdzam wybór i przechodzę dalej'),
                    ))
                  ],
                )),
          Expanded(
            flex: 8,
            child: widget.returnMoreThanOne
                ? ListView.builder(
                    itemCount: widget.dynamicListFromCsvFile[0].length,
                    itemBuilder: (context, index) {
                      return !nameIndexList.contains(index)
                          ? RaisedButton.icon(
                              onPressed: () {
                                addNameIndexToList(index);
                              },
                              icon: Icon(Icons.add),
                              label:
                                  Text(widget.dynamicListFromCsvFile[0][index]))
                          : RaisedButton.icon(
                              onPressed: () {
                                removeNameIndexFromList(index);
                              },
                              icon: Icon(Icons.remove),
                              label:
                                  Text(widget.dynamicListFromCsvFile[0][index]));
                    })
                : ListView.builder(
                    itemCount: widget.dynamicListFromCsvFile[0].length,
                    itemBuilder: (context, index) {
                      return singleIndex == index
                          ? RaisedButton(
                              onPressed: () {},
                              child:
                                  Text(widget.dynamicListFromCsvFile[0][index]),
                            )
                          : RaisedButton.icon(
                              onPressed: () {
                                changePriceIndex(index);
                              },
                              icon: Icon(Icons.add),
                              label:
                                  Text(widget.dynamicListFromCsvFile[0][index]));
                    }),
          )
        ],
      ),
    );
  }
}