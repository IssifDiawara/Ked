import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:green_it/src/domain/models/trees_model.dart';
import 'package:green_it/src/presentation/views/tree_detail_view.dart';
import 'package:latlong2/latlong.dart';

List<Marker> convertDataToMarkers(List<Record> data) {
  List<Marker> markers = [];
  for (Record record in data) {
    final double? latitude = record.geometry?.coordinates?.first;
    final double? longitude = record.geometry?.coordinates?.last;
    if (latitude == null || longitude == null) break;
    final point = LatLng(record.geometry?.coordinates?.last ?? 0, record.geometry?.coordinates?.first ?? 0);
    markers.add(Marker(
      point: point,
      builder: (context) => GestureDetector(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => TreeDetailView(treeRecord: record)));
        },
        child: Image.asset('assets/images/tree.png'),
      ),
    ));
  }
  return markers;
}
