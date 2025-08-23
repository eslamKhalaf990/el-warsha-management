import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfrx/pdfrx.dart';

class PDFViewPage extends StatefulWidget {
  const PDFViewPage({super.key, required this.pdfPath});
  final String pdfPath;

  @override
  State<PDFViewPage> createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  Uint8List? pdfBytes;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final response = await http
          .get(Uri.parse(widget.pdfPath))
          .timeout(const Duration(seconds: 30)); // longer timeout
      if (response.statusCode == 200) {
        setState(() => pdfBytes = response.bodyBytes);
      } else {
        setState(() => error = "Failed with ${response.statusCode}");
      }
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      body: pdfBytes != null
          ? PdfViewer.data(pdfBytes!, sourceName: '',)
          : error != null
          ? Center(child: Text(error!))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
