import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = MapController();

  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = scanToMap;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                map.move(scan.getLatLng(), 15);
              })
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        if (tipoMapa == 'streets') {
          tipoMapa = 'dark';
        } else if (tipoMapa == 'dark') {
          tipoMapa = 'light';
        } else if (tipoMapa == 'light') {
          tipoMapa = 'outdoors';
        } else if (tipoMapa == 'outdoors') {
          tipoMapa = 'satellite';
        } else {
          tipoMapa = 'streets';
        }

        setState(() {});
      },
      child: const Icon(Icons.repeat),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(center: scan.getLatLng(), zoom: 15),
      children: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayer(
      urlTemplate: 'https://api.mapbox.com/v4/'
          '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':
            'pk.eyJ1Ijoia2FpemVuZWxlY3Ryb25pY3MiLCJhIjoiY2tpZ2VyMDc0MHQ1OTJ6bnhkOHkycWNjbCJ9.pJ-6I1guRj47mR2M6ghumA',
        'id': 'mapbox.$tipoMapa'
        // streets, dark, light, outdoors, satellite
      },
    );
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayer(markers: <Marker>[
      Marker(
        width: 100.0,
        height: 100.0,
        point: scan.getLatLng(),
        builder: (context) => Icon(
          Icons.location_on,
          size: 70.0,
          color: Theme.of(context).primaryColor,
        ),
      )
    ]);
  }
}
