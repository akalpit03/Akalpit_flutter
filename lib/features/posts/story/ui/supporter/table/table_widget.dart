import 'package:akalpit/features/posts/story/ui/supporter/table/models/table_block_model_widget.dart';
import 'package:flutter/material.dart';
  

class TableBlockWidget extends StatelessWidget {
  final TableBlockModel model;

  const TableBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade400),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          if (model.headers != null)
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              children: model.headers!
                  .map((h) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          h,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
            ),
          ...model.rows.map(
            (row) => TableRow(
              children: row
                  .map((cell) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(cell),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
