import 'dart:io';
import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:marquee/marquee.dart';
import 'package:mediaboosterproject1/modelClass.dart';
import 'package:mediaboosterproject1/provider.dart';
import 'package:provider/provider.dart';

import 'playing.dart';

class AudioDetails extends StatefulWidget {
  final List<ModalClass> list;
  final int index;

  const AudioDetails({
    Key? key,
    required this.list,
    required this.index,
  }) : super(key: key);

  @override
  State<AudioDetails> createState() => _AudioDetailsState();
}

class _AudioDetailsState extends State<AudioDetails> {

  @override
  void initState() {
    final providerVar=Provider.of<ProviderClass>(context,listen: false);
    // TODO: implement initState
    providerVar.currentSongIndex = widget.index;
    providerVar.player.open(Audio(widget.list[providerVar.currentSongIndex].song!),
        autoStart: false, showNotification: true, loopMode: LoopMode.playlist);

    // player.
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    final providerVar=Provider.of<ProviderClass>(context,listen: false);
    providerVar.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerVar=Provider.of<ProviderClass>(context,listen: true);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/image/image.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 30,
                    )),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Now Playing',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 260,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image:
                              AssetImage(widget.list[providerVar.currentSongIndex].image!),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.list[providerVar.currentSongIndex].singerName!,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 30,
                    width: 150,
                    color: Colors.transparent,
                    child: Center(
                      child: buildAnimatedText(
                        widget.list[providerVar.currentSongIndex].songName!,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            File file = await writeCounter(
                                widget.list[providerVar.currentSongIndex].song!,
                                DateTime.now().microsecond.toString() + '.mp3');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Downloading...',
                                style: TextStyle(
                                    color: Colors.grey.shade200, fontSize: 15),
                              ),
                            ));
                          },
                          icon: Icon(
                            Icons.file_download_outlined,
                            size: 30,
                            color: Colors.white,
                          )),
                      (providerVar.isHeart == true)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  providerVar.isHeart = false;
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.heart_fill,
                                size: 30,
                                color: Colors.red,
                              ))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  providerVar.isHeart = true;

                                });
                                // FavoriteScrren(image: widget.list[currentSongIndex].image,);
                                 FavoriteModel model = FavoriteModel(
                                  image: widget.list[providerVar.currentSongIndex].image,
                                  Songname:
                                      widget.list[providerVar.currentSongIndex].songName,
                                  singerName:
                                      widget.list[providerVar.currentSongIndex].singerName,
                                );
                                 providerVar.Favoritelist.add(model);
                                Fluttertoast.showToast(
                                    msg: 'Added to Favorites');
                              },
                              icon: Icon(
                                CupertinoIcons.heart,
                                color: Colors.white,
                                size: 30,
                              ))
                    ],
                  ),
                  providerVar.player.builderRealtimePlayingInfos(
                      builder: (context, RealtimePlayingInfos? infos) {
                    if (infos == null) {
                      return SizedBox();
                    }
                    return PositionSeekWidget(
                      currentPosition: infos.currentPosition,
                      duration: infos.duration,
                      seekTo: (to) {
                        providerVar.player.seek(to);
                      },
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (providerVar.currentSongIndex > 0) {
                              setState(() {
                                providerVar.currentSongIndex--;
                              });
                            } else {
                              print(providerVar.currentSongIndex);
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.backward_end,
                            color: Colors.white,
                            size: 20,
                          )),
                      (providerVar.isplaying == true)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  providerVar.isplaying = false;
                                  providerVar.player.pause();
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.pause_circle,
                                color: Colors.white,
                                size: 40,
                              ))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  providerVar.isplaying = true;
                                  providerVar.player.play();
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.play_circle,
                                color: Colors.white,
                                size: 40,
                              )),
                      IconButton(
                          onPressed: () {
                            if (providerVar.currentSongIndex != widget.list.length - 1) {
                              setState(() {
                                providerVar.currentSongIndex++;
                                providerVar.isplaying = false;
                              });
                              providerVar.player.open(
                                  Audio(widget.list[providerVar.currentSongIndex].song!),
                                  autoStart: false,
                                  showNotification: true,
                                  loopMode: LoopMode.playlist);
                            }

                          },
                          icon: Icon(
                            CupertinoIcons.forward_end,
                            color: Colors.white,
                            size: 20,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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

  buildAnimatedText(String text) => Marquee(
        text: text,
        style: TextStyle(color: Colors.white, fontSize: 20),
        blankSpace: 30,
        // velocity: 150,
      );
}
