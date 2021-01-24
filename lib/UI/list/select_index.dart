import 'package:flutter/material.dart';

class SelectIndex extends StatefulWidget {
  final List<dynamic> indexNameList;
  final Function selectIndexCallback;
  final bool moreThanOneIndex;

  SelectIndex(
      this.indexNameList, this.selectIndexCallback, this.moreThanOneIndex);

  @override
  _SelectIndexState createState() => _SelectIndexState();
}

class _SelectIndexState extends State<SelectIndex> {
  List<bool> selectedIndexes = [];
  int singleIndex;

  @override
  void initState() {
    if (widget.moreThanOneIndex)
      widget.indexNameList.forEach((element) {
        selectedIndexes.add(false);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.indexNameList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Checkbox(
                  value: selectedIndexes[index],
                  onChanged: (value) {
                    if (widget.moreThanOneIndex) {
                      selectedIndexes[index] = value;
                      widget.selectIndexCallback(selectedIndexes);
                    } else {
                      singleIndex = index;
                      widget.selectIndexCallback(singleIndex);
                    }
                  }),
              Text(widget.indexNameList[index]),
            ],
          );
        });
  }
}
