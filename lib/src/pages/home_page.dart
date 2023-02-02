import 'dart:io';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';

import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: scansBloc.borrarScanTODOS)
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.filter_center_focus),
      ),
    );
  }

  _scanQR(BuildContext context) async {
    dynamic futureString = 'geo:40.71590644448746,-73.91255751093753';
    // dynamic futureString = 'https://www.twitch.tv/';
    // dynamic futureString = 'https://flutter.dev/';

    // dynamic futureString;
    // try {
    //   futureString = await FlutterBarcodeScanner.scanBarcode(
    //     '#ffffff',
    //     'Cancel',
    //     false,
    //     ScanMode.DEFAULT,
    //   );
    // } catch (e) {
    //   futureString = e.toString();
    // }

    if (futureString != null) {
      final scan = ScanModel(
        tipo: futureString.split(':')[0],
        valor: futureString,
      );
      scansBloc.agregarScan(scan);

      if (Platform.isIOS) {
        Future.delayed(const Duration(milliseconds: 750), () {
          utils.abrirScan(context, scan);
        });
      } else {
        // ignore: use_build_context_synchronously
        utils.abrirScan(context, scan);
      }
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 0.0,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          label: 'Direcciones',
        ),
      ],
    );
  }
}
