import 'package:flutter/material.dart';
import 'package:pdf_viewer/pdf_flutter_example.dart';
import 'package:pdf_viewer/pdf_image_renderer_example.dart';
import 'package:pdf_viewer/pdf_previewer_example.dart';
import 'package:pdf_viewer/pdf_render_example.dart';
import 'package:pdf_viewer/pdf_viewer_plugin_example.dart';
import 'advance_pdf_viewer_example.dart';
import 'flutter_fullpdfview_example.dart';
import 'flutter_pdfview_example.dart';
import 'native_pdf_renderer_example.dart';

class DrawerForExamples extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF examples from pub.dev',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MasterPagePage(),
    );
  }
}

class MasterPagePage extends StatefulWidget {
  @override
  _MasterPagePageState createState() => _MasterPagePageState();
}

class _MasterPagePageState extends State<MasterPagePage> {
  int pageNo;
  @override
  void initState() {
    super.initState();
    pageNo = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF demos'),
      ),
      body: getPage(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'PDF plugins',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
           // getTile("FlutterFullPdfViewerExample", 1),
            getTile("NativePdfRendererExample", 2),
            getTile("Current plugin", 3),
            getTile("AdvancePdfViewerExample", 4),
            getTile("PdfRenderExample", 5),
            getTile("PdfFlutter", 6),
            getTile("PdfPreviewerExample", 7),
            getTile("PdfImageRendererExample", 8),
            getTile("FlutterFullpdfviewExample", 9),
            getTile("FlutterPdfviewExample", 10)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getTile(String title, int pageNumber) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: (pageNo == pageNumber ? Colors.blue : Colors.black),
          fontSize: (pageNo == pageNumber ? 18 : 16),
        ),
      ),
      onTap: () {
        setState(() {
          pageNo = pageNumber;
        });
        Navigator.pop(context);
      },
    );
  }

  getPage() {
    switch (pageNo) {
      case 2:
        return NativePdfRendererExample("test");
        break;
        //current plugin
      case 3:
        return PdfViewerPluginExample(
            'https://www.ada.gov/doj-fhwa-ta-glossary.pdf');
        break;
      case 4:
        return AdvancePdfViewerExample();
        break;
      case 5:
        return PdfRenderExample();
        break;
      case 6:
        return PdfFlutter();
        break;
      case 7:
        return PdfPreviewerExample();
        break;
      case 8:
        return PdfImageRendererExample();
        break;
      case 9:
        return FlutterFullpdfviewExample();
        break;
      case 10:
        return FlutterPdfviewExample();
        break;
      default:
    }
  }
}
