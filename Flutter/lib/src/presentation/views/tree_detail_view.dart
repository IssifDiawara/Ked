import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/tree.png', width: 42),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      treeRecord.fields?.frenchLabel?.capitalize ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 42),
              Row(
                children: [
                  Icon(Icons.pin_drop, color: Theme.of(context).colorScheme.onBackground, size: 20),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      treeRecord.fields?.address?.toLowerCase().capitalize ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.tertiary, size: 20),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      '${'species'.tr}: ${treeRecord.fields?.species?.capitalize ?? ''}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.tertiary, size: 20),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      '${'type'.tr}: ${treeRecord.fields?.type?.capitalize ?? ''}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.tertiary, size: 20),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      '${'dominance'.tr}: ${treeRecord.fields?.domination?.capitalize ?? ''}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
