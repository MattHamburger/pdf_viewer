import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PdfViewerPluginExample extends StatefulWidget {
  String url;

  PdfViewerPluginExample(String url) : this.url = url;

  @override
  _PdfViewerPluginExampleState createState() =>
      _PdfViewerPluginExampleState(url);
}

class _PdfViewerPluginExampleState extends State<PdfViewerPluginExample> {
  String path;
  String url;
  _PdfViewerPluginExampleState(String url) : this.url = url;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/doj-fhwa-ta-glossary.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<bool> existsFile() async {
    final file = await _localFile;
    return file.exists();
  }

  Future<Uint8List> fetchPost() async {
    final response = await http.get(url);
    print("response=" + response.toString());
    final responseBytes = response.bodyBytes;

    return responseBytes;
  }

  void loadPdf() async {
    print("await writeCounter(await fetchPost());");
    await writeCounter(await fetchPost());
    print("existsFile()");

    await existsFile();
    print("path = (await _localFile).path;, path=" + path.toString());

    path = (await _localFile).path;
    print("if (!mounted) return;");

    if (!mounted) return;
    print("setState(() {});");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Pdf sample"),
            FlatButton(
              onPressed: () {
                /*...*/
              },
              child: Text(
                "Flat Button what is read",
              ),
            ),
            if (path != null)
              Container(
                height: 300.0,
                child: PdfViewer(
                  filePath: path,
                ),
              )
            else
              Text("Pdf is not Loaded"),
            RaisedButton(
              child: Text("Load pdf"),
              onPressed: loadPdf,
            ),
          ],
        ),
      ),
    );
  }
}
