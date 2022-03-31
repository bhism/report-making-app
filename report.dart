import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class reportt extends StatefulWidget {
  DocumentSnapshot docid;
  reportt({required this.docid});
  @override
  State<reportt> createState() => _reporttState(docid: docid);
}

class _reporttState extends State<reportt> {
  DocumentSnapshot docid;
  _reporttState({required this.docid});
  final pdf = pw.Document();
  var name;
  var subject1;
  var subject2;
  var subject3;

  var marks;
  void initState() {
    setState(() {
      name = widget.docid.get('name');
      subject1 = widget.docid.get('Maths');
      subject2 = widget.docid.get('Science');
      subject3 = widget.docid.get('History');

      marks = int.parse(subject1) + int.parse(subject2) + int.parse(subject3);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      // maxPageWidth: 1000,
      // useActions: false,
      // canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    // final image = await imageFromAssetBundle('assets/r2.svg');

    String? _logo = await rootBundle.loadString('assets/r2.svg');

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Flexible(
                child: pw.SvgImage(
                  svg: _logo,
                  height: 100,
                ),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Center(
                child: pw.Text(
                  'Final Report card',
                  style: pw.TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'name : ',
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  pw.Text(
                    name,
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Maths : ',
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  pw.Text(
                    subject1,
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Science : ',
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  pw.Text(
                    subject2,
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'History : ',
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  pw.Text(
                    subject3,
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Total : ',
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  pw.Text(
                    marks.toString(),
                    style: pw.TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );

    return doc.save();
  }
}
