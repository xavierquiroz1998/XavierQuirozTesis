import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
//import 'package:native_pdf_view/native_pdf_view.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class ViewPdf extends StatefulWidget {
  final Uint8List data;
  ViewPdf({Key? key, required this.data});

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  //late PdfController _pdfController;
  //final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  void initState() {
    // _pdfController = PdfControllerPinch(
    //   document: PdfDocument.openData(widget.data),
    // );

    // _pdfController = PdfController(
    //   document: PdfDocument.openData(widget.data),
    // );
    super.initState();
  }

  @override
  void dispose() {
    //_pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: PdfPreview(
        build: ((format) => widget.data),
      ),
    );
  }
}
