import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:image_to_pdf/data/services/pdf_service.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final List<File> images;
  final PdfService _pdfService = PdfService();

  PdfPreviewPage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Preview"),
      ),
      body: PdfPreview(
        build: (format) => _pdfService.generatePdf(images, format),
        canDebug: false,
        canChangeOrientation: true,
        canChangePageFormat: true,
        allowPrinting: true,
        allowSharing: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "images_converted.pdf",
      ),
    );
  }
}
