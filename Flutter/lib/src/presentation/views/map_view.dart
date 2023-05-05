import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:get/get.dart';
import 'package:green_it/src/core/utils/convert_data_to_markers.dart';
import 'package:green_it/src/di/global_dependencies.dart';
import 'package:green_it/src/domain/blocs/geo_location/geo_location.dart';
import 'package:green_it/src/domain/blocs/trees/trees_cubit.dart';
import 'package:green_it/src/domain/models/trees_model.dart';
import 'package:green_it/src/presentation/views/tree_detail_view.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController mapController = MapController();
  late MapOptions mapOptions;
  final PanelController _panelController = PanelController();
  final GeoLocation geoLocation = getIt<GeoLocation>();

  @override
  void initState() {
    super.initState();

    final LatLng parisCoordinates = LatLng(48.866667, 2.333333);
    mapOptions = MapOptions(center: parisCoordinates, zoom: 12, maxZoom: 17);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final position = await geoLocation.getCurrentLocation();
          mapController.move(LatLng(position.latitude, position.longitude), mapController.zoom);
        },
        mini: true,
        backgroundColor: Colors.white,
        child: const Icon(Icons.gps_fixed, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SlidingUpPanel(
        maxHeight: 400,
        body: BlocBuilder<TreesCubit, TreeState>(builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return const Center(
              child: Text("error loading trees"),
            );
          } else if (state is LoadedState) {
            List<Marker> markers = [];
            if (state.trees.records?.isNotEmpty == true) {
              markers = convertDataToMarkers(
                data: state.trees.records!,
                onTap: (Record treeRecord) {
                  Get.to(TreeDetailView(treeRecord: treeRecord));
                },
              );
            }
            return FlutterMap(
              options: mapOptions,
              mapController: mapController,
              children: [
                TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    maxClusterRadius: 40,
                    anchor: AnchorPos.align(AnchorAlign.center),
                    fitBoundsOptions: const FitBoundsOptions(padding: EdgeInsets.all(50), maxZoom: 15),
                    builder: (BuildContext context, List<Marker> markers) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), color: Theme.of(context).colorScheme.tertiary),
                        child: Center(
                          child: Text(
                            markers.length.toString(),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    markers: markers,
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
        /* header: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Les arbres remarquables de Paris',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),*/
        panelBuilder: (scrollController) => BottomSheetPanel(
          scrollController: scrollController,
          onLocationClicked: (LatLng position) {
            mapController.move(position, mapController.zoom + 4);
          },
        ),
        panelSnapping: true,
        defaultPanelState: PanelState.OPEN,
        controller: _panelController,
      ),
    );
  }
}

class BottomSheetPanel extends StatelessWidget {
  final ScrollController scrollController;
  final Function(LatLng position)? onLocationClicked;
  const BottomSheetPanel({required this.scrollController, this.onLocationClicked, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreesCubit, TreeState>(builder: (context, state) {
      if (state is LoadedState) {
        return ListView.separated(
            padding: const EdgeInsets.all(16),
            controller: scrollController,
            itemBuilder: (context, index) {
              final Record treeRecord = state.trees.records!.elementAt(index);
              final Field treeField = treeRecord.fields!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      onLocationClicked?.call(
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
              return const Divider(thickness: 4);
            },
            itemCount: state.trees.records?.where((Record record) => record.fields != null).length ?? 0);
      }
      return const SizedBox.shrink();
    });
  }
}
