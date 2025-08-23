import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PDFViewPage extends StatelessWidget {
  const PDFViewPage({super.key, required this.pdfPath});

  final String pdfPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      body: PdfViewer.uri(
        Uri.parse(pdfPath),
      ),
    );
  }
}
