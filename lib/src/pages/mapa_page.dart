import 'package:flutter/material.dart';
import 'package:qr_reader/src/models/can_model.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: Text('${scan.valor}'),
      ),
    );
  }
}
