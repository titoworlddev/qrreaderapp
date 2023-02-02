import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  final scansBloc = ScansBloc();

  MapasPage({super.key});

  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final scans = snapshot.data;

        if (scans!.isEmpty) {
          return const Center(
            child: Text('No hay información'),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.center,
              color: Colors.red,
              child: const Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) => scansBloc.borrarScan(scans[i].id!),
            child: ListTile(
              leading: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[i].valor!),
              subtitle: Text('ID: ${scans[i].id}'),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => utils.abrirScan(context, scans[i]),
            ),
          ),
        );
      },
    );
  }
}
