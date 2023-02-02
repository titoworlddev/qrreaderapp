import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

ScanModel scanToMap = ScanModel();

abrirScan(BuildContext context, ScanModel scan) async {
  scanToMap = scan;
  if (scan.tipo == 'http' || scan.tipo == 'https') {
    if (await canLaunchUrl(Uri.parse(scan.valor!))) {
      await launchUrl(Uri.parse(scan.valor!));
    } else {
      throw 'Could not launch ${scan.valor}';
    }
  } else {
    Navigator.pushNamed(context, 'mapa');
  }
}
