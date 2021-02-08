import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/pages/direcciones_page.dart';
import 'package:qr_reader/src/pages/mapas_page.dart';
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';
import 'package:qr_reader/src/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/src/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () => _mostrarAlerta(context),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _mostrarAlerta(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '¿Desea eliminar todos los scanners?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Provider.of<ScanListProvider>(context, listen: false)
                        .borrarTodos();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 16),
                  )),
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          );
        });
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // obtener el selectedMenuOpt
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    // TODO: Temporal leer la DB
    // final tempScan = new ScanModel(valor: 'http:google.com');
    // DBProvider.db.nuevoScan(tempScan).then((value) => print(value));
    // DBProvider.db.getScans().then((value) {
    //   for (var scan in value) {
    //     print('${scan.id}: ${scan.valor}');
    //   }
    // });

    // usar el scan_lis_provider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
