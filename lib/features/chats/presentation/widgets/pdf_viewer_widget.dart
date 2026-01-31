import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerWidget extends StatelessWidget {
  final String pdfLink;
  const PdfViewerWidget({super.key , required this.pdfLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: SfPdfViewer.network(pdfLink)));
  }
}
