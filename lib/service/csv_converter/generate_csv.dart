import 'package:tata_app/service/file/file_service.dart';

class GenerateCsv {
  final List<List<dynamic>> dynamicListFromCsvFile;
  final List<int> uniqueNameColumnIndex;
  final List<int> extraDataForMinAndMaxValues;
  final int priceIndex;
  final int amountIndex;

  GenerateCsv(this.dynamicListFromCsvFile, this.priceIndex, this.amountIndex,
      this.extraDataForMinAndMaxValues, this.uniqueNameColumnIndex);

  Map<String, List<List<dynamic>>> orderCompareMap =
      Map<String, List<List<dynamic>>>();
  List<List<dynamic>> finalList = List<List<dynamic>>();

  createOrderMap() {
    for (int i = 1; i < dynamicListFromCsvFile.length; i++) {
      String uniqueName = '';
      uniqueNameColumnIndex.forEach((elementIndex) {
        uniqueName += dynamicListFromCsvFile[i][elementIndex];
      });
      orderCompareMap.update(uniqueName, (value) {
        value.add(dynamicListFromCsvFile[i]);
        return value;
      }, ifAbsent: () {
        List<List<dynamic>> newList = List<List<dynamic>>();
        newList.add(dynamicListFromCsvFile[i]);
        return newList;
      });
    }
  }

  returnMinValue(List<List<dynamic>> list) {
    List<dynamic> minValueList = list[0];
    list.forEach((element) {
      if (minValueList[priceIndex].toDouble() >
          element[priceIndex].toDouble()) {
        minValueList = element;
      }
    });
    return minValueList;
  }

  returnMidValue(List<List<dynamic>> list) {
    double sum = 0;
    list.forEach((element) {
      sum += element[priceIndex].toDouble();
    });
    return sum / list.length;
  }

  returnMaxValue(List<List<dynamic>> list) {
    List<dynamic> maxValueList = list[0];
    list.forEach((element) {
      if (maxValueList[priceIndex].toDouble() <
          element[priceIndex].toDouble()) {
        maxValueList = element;
      }
    });
    return maxValueList;
  }

  returnSumValue(List<List<dynamic>> list) {
    double sum = 0;
    list.forEach((element) {
      sum += element[priceIndex].toDouble() * element[amountIndex].toDouble();
    });
    return sum;
  }

  generateFirstRow() {
    List<String> list=[];
    String temp='';
    uniqueNameColumnIndex.forEach((element) {
      temp+=dynamicListFromCsvFile[0][element];
    });
    list.add(temp);
    list.add('Min');
    extraDataForMinAndMaxValues.forEach((element) {
      list.add(dynamicListFromCsvFile[0][element]);
    });
    list.add('Mid');
    list.add('Max');
    extraDataForMinAndMaxValues.forEach((element) {
      list.add(dynamicListFromCsvFile[0][element]);
    });
    list.add('Max/Min');
    list.add('suma');
    return list;
  }

  createSortedOrderCompareList() {
    finalList.add(generateFirstRow());
    orderCompareMap.forEach((uniqueName, listOfOrders) {
      List<dynamic> newSingleRow = [];
      newSingleRow.add(uniqueName);
      List<dynamic> minRow = returnMinValue(listOfOrders);
      newSingleRow.add(minRow[priceIndex].toStringAsFixed(2));
      extraDataForMinAndMaxValues.forEach((element) {
        newSingleRow.add(minRow[element]);
      });
      newSingleRow.add(returnMidValue(listOfOrders).toStringAsFixed(2));
      List<dynamic> maxRow = returnMaxValue(listOfOrders);
      newSingleRow.add(maxRow[priceIndex].toStringAsFixed(2));
      extraDataForMinAndMaxValues.forEach((element) {
        newSingleRow.add(maxRow[element]);
      });
      newSingleRow.add((maxRow[priceIndex] / minRow[priceIndex]).toStringAsFixed(2));
      newSingleRow.add(returnSumValue(listOfOrders).toStringAsFixed(2));
      finalList.add(newSingleRow);
    });
  }

  saveToExternalStorage() {
    orderCompareMap.clear();
    createOrderMap();
    finalList.clear();
    createSortedOrderCompareList();
    FileService().convertDynamicListToCsvFile(finalList);
  }
}
