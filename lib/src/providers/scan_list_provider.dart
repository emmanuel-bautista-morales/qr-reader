import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // asignar el id de la base de datos al modelo
    nuevoScan.id = id;

    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
    }
    notifyListeners();
    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteScans();
    this.scans = [];
    notifyListeners();
  }

  borrarPorId(int id) async {
    final scanBorrado = await DBProvider.db.deleteScan(id);
    // this.scans = this.scans.where((scan) => scan.id != scanBorrado).toList();
    // this.cargarScansPorTipo(this.tipoSeleccionado);
    // notifyListeners();
  }
}
