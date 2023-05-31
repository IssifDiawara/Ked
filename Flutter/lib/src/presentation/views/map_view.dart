import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:get/get.dart';
import 'package:green_it/src/core/utils/convert_data_to_markers.dart';
import 'package:green_it/src/core/utils/geo_location.dart';
import 'package:green_it/src/di/global_dependencies.dart';
import 'package:green_it/src/domain/blocs/trees/trees_cubit.dart';
import 'package:green_it/src/domain/models/trees_model.dart';
import 'package:green_it/src/presentation/views/tree_detail_view.dart';
import 'package:green_it/src/presentation/widgets/tree_detail_draggable_bottom_sheet.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController mapController = MapController();
  late MapOptions mapOptions;
  final GeoLocation geoLocation = getIt<GeoLocation>();
  final double defaultZoom = 12;
  final double maxZoom = 17;

  @override
  void initState() {
    super.initState();

    final LatLng parisCoordinates = LatLng(48.866667, 2.333333);
    mapOptions = MapOptions(center: parisCoordinates, zoom: defaultZoom, maxZoom: maxZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final position = await geoLocation.getCurrentLocation();
          mapController.move(LatLng(position.latitude, position.longitude), defaultZoom);
        },
        mini: true,
        backgroundColor: Colors.white,
        child: const Icon(Icons.gps_fixed, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          BlocBuilder<TreesCubit, TreeState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ErrorState) {
                return const Center(child: Text("error loading trees"));
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
            },
          ),
          TreeDetailDraggableBottomSheet(
            onLocationClicked: (LatLng position) {
              mapController.move(position, defaultZoom + 10);
            },
          ),
        ],
      ),
    );
  }
}
