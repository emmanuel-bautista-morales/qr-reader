import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;

  const ScanTiles({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarPorId(scans[i].id);
        },
        child: ListTile(
          leading: Icon(this.tipo == 'geo' ? Icons.map : Icons.home_outlined
              // color: Theme.of(context).se,
              ),
          title: Text(scans[i].valor),
          subtitle: Text('ID: ${scans[i].id}'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            launchURL(context, scans[i]);
          },
        ),
      ),
    );
  }
}
