import 'package:flutter/material.dart';
import 'package:tata_app/info_screen.dart';
import 'package:tata_app/tile.dart';

class ShowTiles extends StatefulWidget {
  final List<List<dynamic>> orderList;

  ShowTiles(this.orderList);

  @override
  _ShowTilesState createState() => _ShowTilesState();
}

class _ShowTilesState extends State<ShowTiles> {
  Map<String, List<List<dynamic>>> orderCompareMap = Map<String, List<List<dynamic>>>();
  Map<String, List<List<dynamic>>> sortedOrderCompareMap = Map<String, List<List<dynamic>>>();

  @override
  Widget build(BuildContext context) {
    getComaration();
    return sortedOrderCompareMap == null || sortedOrderCompareMap.isEmpty ? Text('No data'):Expanded(
        child: ListView.builder(
            itemCount: sortedOrderCompareMap.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Tile(sortedOrderCompareMap.keys.toList()[index],sortedOrderCompareMap[sortedOrderCompareMap.keys.toList()[index]]),
                ),
              );
            })) ;
  }

  getComaration() {
    widget.orderList.forEach((element) {
      orderCompareMap.update('${element[0]} ${element[2]}', (value) {
        value.add(element,);
        return value;
      },ifAbsent:() {
        List<List<dynamic>> newList = List<List<dynamic>>();
        newList.add(element);
        return newList;
      });
    });
    createSortedMap();
  }

  createSortedMap(){
    setState(() {
      sortedOrderCompareMap = Map.fromEntries(
          orderCompareMap.entries.toList()..sort((e1, e2) =>(returnDifference(e2.value)).compareTo(returnDifference(e1.value)))
      );

    });
  }
  double returnDifference(List<dynamic> list){
    return returnMaxPrice(list)/returnMinPrice(list);
  }
  double returnMinPrice(List<dynamic> list) {
    double minPrice;
    list.forEach((element) {
      if (element[3].runtimeType == double) {
        if (minPrice == null) minPrice = element[3];
        if (element[3] < minPrice) minPrice = element[3];
      } else {
        return 0.0;
      }
    });
    return minPrice ?? 0.0;
  }
  double returnMaxPrice(List<dynamic> list) {
    double maxPrice;
    list.forEach((element) {
      if (element[3].runtimeType == double) {
        if (maxPrice == null) maxPrice = element[3];
        if (element[3] > maxPrice) maxPrice = element[3];
      } else {
        return 0.0;
      }
    });
    return maxPrice?? 0.0;
  }

}
