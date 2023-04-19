import 'package:flutter/material.dart';
import 'package:green_it/src/domain/models/trees_model.dart';

class TreeDetailView extends StatelessWidget {
  final Record treeRecord;
  const TreeDetailView({required this.treeRecord, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Text("TreeDetailView"),
      ),
    );
  }
}
