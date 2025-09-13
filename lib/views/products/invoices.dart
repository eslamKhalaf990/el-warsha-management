import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:printing/printing.dart';
import 'package:warsha_app/utils/default_text.dart';

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
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        setState(() => pdfBytes = response.bodyBytes);
      } else {
        setState(() => error = "Failed to load PDF with status: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => error = "Error loading PDF: $e");
    }
  }

  // 2. Create a function to handle the printing logic
  Future<void> _printPdf() async {
    // Check if the PDF bytes are loaded
    if (pdfBytes != null) {
      // Use the Printing.layoutPdf function to print the PDF
      await Printing.layoutPdf(onLayout: (format) async => pdfBytes!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DefaultText(txt: "Invoice", size: 16, bold: true,),

        actions: [
          // We only want to show the print button if the PDF has been loaded
          if (pdfBytes != null)
            Row(
              children: [
                const DefaultText(txt: "Save & Print", size: 16, bold: true,),
                const SizedBox(width: 5,),
                IconButton(
                  icon: const Icon(Iconsax.printer),
                  tooltip: 'Print PDF',
                  onPressed: _printPdf,
                ),
              ],
            ),
        ],
      ),
      body: pdfBytes != null
          ? PdfViewer.data(
        pdfBytes!,
        sourceName: widget.pdfPath, // It's good practice to provide a sourceName
      )
          : error != null
          ? Center(child: Text(error!))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}