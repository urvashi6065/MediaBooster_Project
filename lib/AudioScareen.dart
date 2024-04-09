import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediaboosterproject1/modelClass.dart';
import 'package:mediaboosterproject1/provider.dart';
import 'package:provider/provider.dart';

import 'audioDetail.dart';

class audioScreen extends StatefulWidget {
  const audioScreen({Key? key}) : super(key: key);

  @override
  State<audioScreen> createState() => _audioScreenState();
}

class _audioScreenState extends State<audioScreen> {


  @override
  Widget build(BuildContext context) {
    final providerVar=Provider.of<ProviderClass>(context,listen: true);
    return ListView.builder(
      itemCount: providerVar.audioList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AudioDetails(
                      list: providerVar.audioList,
                      index: index,
                    )));
          },
          leading: Container(
            height: 50,
            width: 55,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(providerVar.audioList[index].image!),
                    fit: BoxFit.fill)),
          ),
          title: Text(
            providerVar.audioList[index].songName!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: CupertinoColors.white),
          ),
          subtitle: Text(
            providerVar.audioList[index].singerName!,
            style: TextStyle(color: CupertinoColors.white),
          ),
          trailing: PopupMenuButton(
            // color: Colors.red,
            iconColor: Colors.white,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Download',
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () async {
                          File file = await writeCounter(providerVar.audioList[index].song!,
                              DateTime.now().microsecond.toString() + '.mp3');
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              'Downloading...',
                              style: TextStyle(
                                  color: Colors.grey.shade200, fontSize: 15),
                            ),
                          ));
                        },
                        icon: Icon(Icons.download)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<File> writeCounter(String song, String name) async {
    ByteData bytes = await rootBundle.load(song);
    Uint8List byte = bytes.buffer.asUint8List();
    Directory directory = Directory("storage/emulated/0/Download");
    print(directory);
    final exPath = directory.path;
    print("Saved path:$exPath");
    await Directory(exPath).create(recursive: true);
    final String path = exPath;
    File file = File("$exPath/$name");
    print('Save file');
    return file.writeAsBytes(byte);
  }
}
