import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:radreviews/size_config.dart';

class TandC extends StatefulWidget {

  String url;
TandC(this.url);
  @override
  _TandCState createState() => _TandCState();
}
bool _waiting=false;
class _TandCState extends State<TandC> {

  void initState() {
    setState(() {
      _waiting=true;
    });
    loadPdf().whenComplete(() {
      setState(() {_waiting=false;});
      print("success");
    }).catchError((error, stackTrace) {
      setState(() {_waiting=false;});
      print("outer: $error");
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
    final response = await http.get(
        widget.url);
    final responseJson = response.bodyBytes;

    return responseJson;
  }

  Future<bool> loadPdf() async {
    await writeCounter(await fetchPost());
    await existsFile();
    path = (await _localFile).path;
return true;

  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(inAsyncCall: _waiting,
      child: Scaffold(
          appBar: AppBar(centerTitle: true,
            title: Column(
              children: [SizedBox(height: 10.0),
                Text('Terms & Conditions',textAlign: TextAlign.center,),
              ],
            ),
          ),
          body: Container(
            child:
            path != null?
                Container(
                  height: 85 * SizeConfig.heightMultiplier,
                  child: PdfViewer(
                    filePath: path,
                  ),
                ):
                Text("Loading pdf..."),


          ),
        ),
    );

  }
}