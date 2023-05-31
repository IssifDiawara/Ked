import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:green_it/src/domain/blocs/trees/trees_cubit.dart';
import 'package:green_it/src/domain/models/trees_model.dart';
import 'package:green_it/src/presentation/views/tree_detail_view.dart';
import 'package:latlong2/latlong.dart';

class TreeDetailDraggableBottomSheet extends StatelessWidget {
  final Function(LatLng position) onLocationClicked;
  const TreeDetailDraggableBottomSheet({super.key, required this.onLocationClicked});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreesCubit, TreeState>(builder: (context, state) {
      if (state is LoadedState) {
        return DraggableScrollableSheet(
          maxChildSize: 0.5,
          builder: (BuildContext context, scrollController) {
            return Container(
              color: Colors.white,
              child: ListView.separated(
                shrinkWrap: true,
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  if (index == 0) return const Divider(thickness: 4, endIndent: 150, indent: 150, color: Colors.grey);
                  final Record treeRecord = state.trees.records!.elementAt(index);
                  final Field treeField = treeRecord.fields!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Image.asset('assets/images/tree.png', width: 28),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              treeField.frenchLabel?.capitalize ?? '',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (treeRecord.geometry?.coordinates?.isEmpty == true) return;
                          onLocationClicked.call(
                            LatLng(treeRecord.geometry!.coordinates!.last, treeRecord.geometry!.coordinates!.first),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 16),
                          child: Row(
                            children: [
                              Icon(Icons.pin_drop, color: Theme.of(context).colorScheme.onBackground, size: 20),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  treeField.address?.toLowerCase().capitalize ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.outline,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.tertiary, size: 20),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '${'species'.tr}: ${treeField.species?.capitalize ?? ''}',
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
                              '${'type'.tr}: ${treeField.type?.capitalize ?? ''}',
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
                              '${'dominance'.tr}: ${treeField.domination?.capitalize ?? ''}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Background color
                            ),
                            onPressed: () {
                              Get.to(TreeDetailView(treeRecord: state.trees.records!.elementAt(index)));
                            },
                            child: Text(
                              'find_out_more'.tr,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  if (index == 0) return const SizedBox.shrink();
                  return const Divider(thickness: 2);
                },
                itemCount: state.trees.records?.where((Record record) => record.fields != null).length ?? 0 + 1,
              ),
            );
          },
        );
      }
      return const SizedBox.shrink();
    });
  }
}
