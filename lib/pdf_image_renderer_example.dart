import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';


class PdfImageRendererExample extends StatefulWidget {
  @override
  _PdfImageRendererExampleState createState() => _PdfImageRendererExampleState();
}

class _PdfImageRendererExampleState extends State<PdfImageRendererExample> {
  int pageIndex = 0;
  Uint8List image;

  bool open;

  PdfImageRendererPdf pdf;
  int count;
  PdfImageRendererPageSize size;

  bool cropped = false;

  @override
  void initState() {
    super.initState();
  }

  renderPage() async {
    size = await pdf.getPageSize(pageIndex: pageIndex);
    final i = await pdf.renderPage(
      pageIndex: pageIndex,
      x: cropped ? 100 : 0,
      y: cropped ? 100 : 0,
      width: cropped ? 100 : size.width,
      height: cropped ? 100 : size.height,
      scale: 3,
      background: Colors.white,
    );

    setState(() {
      image = i;
    });
  }

  openPdf({@required String path}) async {
    if (pdf != null) {
      await pdf.close();
    }
    pdf = PdfImageRendererPdf(path: path);
    await pdf.open();
    setState(() {
      open = true;
    });
  }

  closePdf() async {
    if (pdf != null) {
      await pdf.close();
      setState(() {
        open = false;
      });
    }
  }

  openPdfPage({@required int pageIndex}) async {
    await pdf.openPage(pageIndex: pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: <Widget>[
            if (open == true)
              IconButton(
                icon: Icon(Icons.crop),
                onPressed: () {
                  cropped = !cropped;
                  renderPage();
                },
              )
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('Select PDF'),
                  onPressed: () async {
                    String path = await FilePicker.getFilePath(type: FileType.custom, allowedExtensions: ['pdf']);

                    if (path != null) {
                      await openPdf(path: path);
                      pageIndex = 0;
                      count = await pdf.getPageCount();
                      await openPdfPage(pageIndex: pageIndex);
                      renderPage();
                    }
                  },
                ),
                if (count != null) Text('The selected PDF has $count pages.'),
                if (image != null) Text('It is ${size.width} wide and ${size.height} high.'),
                if (open == true)
                  RaisedButton(
                    child: Text('Close PDF'),
                    onPressed: () async {
                      await closePdf();
                    },
                  ),
                if (image != null) ...[
                  Text('Rendered image area:'),
                  Image(image: MemoryImage(image)),
                ],
                if (open == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: pageIndex > 0
                            ? () async {
                          pageIndex -= 1;
                          await openPdfPage(pageIndex: pageIndex);
                          renderPage();
                        }
                            : null,
                        icon: Icon(Icons.chevron_left),
                        label: Text('Previous'),
                      ),
                      FlatButton.icon(
                        onPressed: pageIndex < (count - 1)
                            ? () async {
                          pageIndex += 1;
                          await openPdfPage(pageIndex: pageIndex);
                          renderPage();
                        }
                            : null,
                        icon: Icon(Icons.chevron_right),
                        label: Text('Next'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}