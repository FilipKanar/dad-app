import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final String index;
  final List<dynamic> orderList;

  Tile(this.index, this.orderList);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  double minimumPrice;
  double maximumPrice;
  double mediumPrice;

  double returnSumPrice() {
    double sum = 0;
    widget.orderList.forEach((element) {
      if (element[3].runtimeType == double) {
        sum += element[3];
      } else {
        sum = 0.0;
      }
    });
    return sum;
  }

  double returnMinPrice() {
    double minPrice;
    widget.orderList.forEach((element) {
      if (element[3].runtimeType == double) {
        if (minPrice == null) minPrice = element[3];
        if (element[3] < minPrice) minPrice = element[3];
      } else {
        return 0.0;
      }
    });
    return minPrice ?? 0.0;
  }

  double returnMidPrice() {
    return  returnSumPrice() / widget.orderList.length;
  }

  double returnMaxPrice() {
    double maxPrice;
    widget.orderList.forEach((element) {
      if (element[3].runtimeType == double) {
        if (maxPrice == null) maxPrice = element[3];
        if (element[3] > maxPrice) maxPrice = element[3];
      } else {
        return 0.0;
      }
    });
    return maxPrice?? 0.0;
  }

  double returnPercentage() {
    return returnMaxPrice() / returnMinPrice();
  }

  @override
  Widget build(BuildContext context) {
    return widget.orderList.isEmpty
        ? Text('No Orders')
        : Container(
      padding: EdgeInsets.all(9),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                //Text(widget.index),
                Text(widget.orderList.first[0]+widget.orderList.first[2]),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(returnMinPrice().toStringAsFixed(2)),
                Text(returnMidPrice().toStringAsFixed(2)),
                Text(returnMaxPrice().toStringAsFixed(2)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(returnPercentage().toStringAsFixed(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
