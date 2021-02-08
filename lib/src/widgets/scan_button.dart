import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.filter_center_focus,
        color: Colors.white,
      ),
      elevation: 0,
      onPressed: () async {
        final barcodeScanRes = 'geo:45.280089,-75.922405';

        if (barcodeScanRes == '-1') return;

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        launchURL(context, nuevoScan);
        // scanListProvider.nuevoScan(barcodeScanRes);
      },
      // backgroundColor: Theme.of(context).accentColor,
    );
  }
}
