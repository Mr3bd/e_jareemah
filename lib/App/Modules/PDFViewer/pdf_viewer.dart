import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewer extends StatefulWidget {
  final String title;
  final String fileName;
  const PdfViewer({Key? key, required this.title, required this.fileName})
      : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PdfControllerPinch pdfController;

  @override
  void initState() {
    pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/docs/${widget.fileName}.pdf'),
    );
    super.initState();
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: PdfViewPinch(
        builders: const PdfViewPinchBuilders<DefaultBuilderOptions>(
          options: DefaultBuilderOptions(),
        ),
        controller: pdfController,
      ),
    );
  }
}
