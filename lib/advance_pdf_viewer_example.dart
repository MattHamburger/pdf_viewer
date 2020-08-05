import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class AdvancePdfViewerExample extends StatefulWidget {
  @override
  _AdvancePdfViewerExampleState createState() =>
      _AdvancePdfViewerExampleState();
}

class _AdvancePdfViewerExampleState extends State<AdvancePdfViewerExample> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/doj-fhwa-ta-glossary.pdf');

    setState(() => _isLoading = false);
  }

  changePDF(value) async {
    setState(() => _isLoading = true);
    if (value == 1) {
      document = await PDFDocument.fromAsset('assets/doj-fhwa-ta-glossary.pdf');
    } else if (value == 2) {
      document = await PDFDocument.fromURL(
          "https://www.ada.gov/doj-fhwa-ta-glossary.pdf");
    } else {
      document = await PDFDocument.fromAsset('assets/doj-fhwa-ta-glossary.pdf');
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    //changePDF(1);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterPluginPDFViewer'),
        ),
        body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                  //uncomment below line to preload all pages
                  // lazyLoad: false,
                  // uncomment below line to scroll vertically
                  // scrollDirection: Axis.vertical,

                  //uncomment below code to replace bottom navigation with your own
                  /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, */
                ),
        ),
      ),
    );
  }
}
