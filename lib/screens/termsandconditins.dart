import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:radreviews/size_config.dart';

class TandC extends StatefulWidget {
  String url;

  TandC(this.url);

  @override
  _TandCState createState() => _TandCState();
}

class _TandCState extends State<TandC> {
  void initState() {

    loadPdf().whenComplete(() {

    }).catchError((error, stackTrace) {

    });

    super.initState();
  }

  String path;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste.pdf');
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
    final response = await http.get(widget.url);
    final responseJson = response.bodyBytes;

    return responseJson;
  }

  Future<bool> loadPdf() async {
    await writeCounter(await fetchPost());
    await existsFile();
    path = (await _localFile).path;
    print(path);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 12.25 * SizeConfig.heightMultiplier,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(1.15, -0.25),
                end: Alignment(-1.08, -0.32),
                colors: [const Color(0xff1b0e97), const Color(0xff881c8e)],
                stops: [0.0, 1.0],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'TERMS & CONDITIONS',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 1.9 * SizeConfig.heightMultiplier,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 3.3 * SizeConfig.heightMultiplier,
                ),
              ],
            ),
          ),
          Container(
            child: path != null
                ? Container(
                    height: 75 * SizeConfig.heightMultiplier,
                    child: PdfViewer(
                      filePath: path,
                    ),
                  )
                : Container(
                    height: 75 * SizeConfig.heightMultiplier,
                    child: Center(
                      child: Text(
                        "Loading pdf...",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
