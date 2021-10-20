import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class NewsTile extends StatefulWidget {
  final String imgUrl, title, desc, content, posturl;

  NewsTile(
      {required this.imgUrl,
      required this.desc,
      required this.title,
      required this.content,
      required this.posturl});

  @override
  _NewsTileState createState() => _NewsTileState(
        imgUrl: this.imgUrl,
        desc: this.desc,
        title: this.title,
        content: this.content,
        posturl: this.posturl,
      );
}

class _NewsTileState extends State<NewsTile> {
  var debug = true;
  final String imgUrl, title, desc, content, posturl;

  _NewsTileState(
      {required this.imgUrl,
      required this.desc,
      required this.title,
      required this.content,
      required this.posturl});

  //ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    FlutterDownloader.initialize(debug: true);
  }

  void _download(String url) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final externalDir = await DownloadsPathProvider.downloadsDirectory;

      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: externalDir!.path,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      print('Permission Denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterDownloader.initialize(debug: true);

    return GestureDetector(
      onTap: () async {
       // downloadFile(this.imgUrl);

         requestDownload(this.imgUrl);

        /* final status = await Permission.storage.request();

        if (status.isGranted) {

        }*/
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imgUrl,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget getNetworkImage(String _url) {
    var assetImage = NetworkImage(_url);
    Image image = Image(
      image: assetImage,
    );
    return Container(
      child: image,
    );
  }


 /* Future<String> getFilePath(uniqueFileName) async {
    String path = '';

  //  Directory dir = await getApplicationDocumentsDirectory();
    Directory dir = Directory('/storage/emulated/0/Download');

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  Future downloadFile(String imageUrl) async {
    bool downloading = true;
    String downloadingStr = "No data";
    String savePath = "";

    try {
      Dio dio = Dio();

      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      savePath = await getFilePath(fileName);
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          downloadingStr = "Downloading Image : $rec";
        });
      });
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _fileDownload(String _url) async {
    Directory? tempDir;
    if (Platform.isAndroid) {
      tempDir = await DownloadsPathProvider.downloadsDirectory;
    }
    //for ios
    // await getApplicationDocumentsDirectory();

    String tempPath = tempDir!.path;
    var filePath = tempPath;
    final savedDir = Directory(tempPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    final taskId = await FlutterDownloader.enqueue(
      url: _url,
      savedDir: filePath,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }
*/
  Future<void> requestDownload(String _url) async {
    Directory dir = Directory('/storage/emulated/0/Download');
    var _localPath = dir.path;
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      var _taskid = await FlutterDownloader.enqueue(
        url: _url,
        saveInPublicStorage: true,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: false,
      );
    });
  }
}
