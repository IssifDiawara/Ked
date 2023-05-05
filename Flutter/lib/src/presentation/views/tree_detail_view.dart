import 'package:flutter/material.dart';
import 'package:green_it/src/domain/models/trees_model.dart';

class TreeDetailView extends StatelessWidget {
  final Record treeRecord;
  const TreeDetailView({required this.treeRecord, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('${treeRecord.fields?.domination}'),
              Text('${treeRecord.fields?.type}'),
              Text('${treeRecord.fields?.species}'),
              Text('${treeRecord.fields?.frenchLabel}'),
              Text('${treeRecord.fields?.address}'),
              Text('${treeRecord.geometry?.coordinates}'),
            ],
          ),
        ),
      ),
    );
  }
}
