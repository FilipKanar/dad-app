import 'package:flutter/material.dart';
import 'package:tata_app/UI/options/components/choose_columns.dart';
import 'package:tata_app/service/csv_converter/generate_csv.dart';

class UserChoice extends StatefulWidget {
  final List<List<dynamic>> dynamicListFromCsvFile;

  UserChoice(this.dynamicListFromCsvFile);

  @override
  _UserChoiceState createState() => _UserChoiceState();
}

class _UserChoiceState extends State<UserChoice> {
  List<int> _uniqueNameColumnIndexList = [];
  int _priceIndex;
  int _amountIndex;
  List<int> _extraDataList = [];
  bool _extraDataCheck = false;

  setUniqueColumnIndexList(List<int> list) {
    setState(() {
      list.forEach((element) {
        _uniqueNameColumnIndexList.add(element);
      });
    });
  }

  setExtraDataList(List<int> list) {
    _extraDataList.clear();
    setState(() {
      list.forEach((element) {
        _extraDataList.add(element);
      });
      _extraDataCheck = false;
    });
    print('Lista: ' + _extraDataList.toString());
  }

  setPriceIndex(int index) {
    setState(() {
      _priceIndex = index;
      print('Cena: ' + _priceIndex.toString());
    });
  }

  setAmountIndex(int index) {
    setState(() {
      _amountIndex = index;
      print('Amount: ' + _amountIndex.toString());
    });
  }

  getNameColumnList() {
    List<String> list = [];
    _uniqueNameColumnIndexList.forEach((element) {
      list.add(widget.dynamicListFromCsvFile[0][element]);
    });
    return list;
  }

  getExtraDataColumnList() {
    List<String> list = [];
    _extraDataList.forEach((element) {
      list.add(widget.dynamicListFromCsvFile[0][element]);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (_uniqueNameColumnIndexList.isEmpty)
      return ChooseColumns(
        widget.dynamicListFromCsvFile,
        setUniqueColumnIndexList,
        'Wybierz nazwy kolumn z których stworzysz unikalną nazwę',
        returnMoreThanOne: true,
      );
    if (_uniqueNameColumnIndexList.isNotEmpty && _priceIndex == null)
      return ChooseColumns(
        widget.dynamicListFromCsvFile,
        setPriceIndex,
        "Wybierz nazwę kolumny z ceną",
      );
    if (_uniqueNameColumnIndexList.isNotEmpty &&
        _priceIndex != null &&
        _amountIndex == null)
      return ChooseColumns(widget.dynamicListFromCsvFile, setAmountIndex,
          "Wybierz kolumnę z ilością");
    if (_uniqueNameColumnIndexList.isNotEmpty &&
        _priceIndex != null &&
        _amountIndex != null)
      return _extraDataCheck
          ? ChooseColumns(
              widget.dynamicListFromCsvFile,
              setExtraDataList,
              "Wybierz dane które wyświetlą się przy minimalnym i maksymalnym zamowieniu",
              returnMoreThanOne: true,
            )
          : Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Text('Kolumny wybrane jako unikatowa nazwa: ' +
                        getNameColumnList().toString()),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _uniqueNameColumnIndexList.clear();
                        });
                      },
                      child: Text('Zmień kolumny z nazwą'),
                    ),
                  ),
                  Center(
                    child: Text('Kolumna z ceną: ' +
                        widget.dynamicListFromCsvFile[0][_priceIndex]),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _priceIndex = null;
                        });
                      },
                      child: Text('Zmień kolumnę z ceną'),
                    ),
                  ),
                  Center(
                    child: Text('Kolumna z iloscia: ' +
                        widget.dynamicListFromCsvFile[0][_amountIndex]),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _amountIndex = null;
                        });
                      },
                      child: Text('Zmień kolumnę z ilością'),
                    ),
                  ),
                  Center(
                    child: Text(
                        'Wybierz dodatkowe dane które chcesz zobaczyć przy zamowieniu o minimalnej i maksymalnej wartosci. Aktualnie wybrane: ' +
                            getExtraDataColumnList().toString()),
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _extraDataCheck = true;
                        });
                      },
                      child: Text('Wybierz dodatkowe dane'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(21.37),
                      child: RaisedButton(
                        onPressed: () {
                          GenerateCsv(widget.dynamicListFromCsvFile,_priceIndex,_amountIndex,_extraDataList,_uniqueNameColumnIndexList).saveToExternalStorage();
                        },
                        child: Text('Potweirdzam i przechodzę dalej'),
                      ),
                    ),
                  ),
                ],
              ),
            );
    return Container();
  }
}