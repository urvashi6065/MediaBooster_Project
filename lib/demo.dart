import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaboosterproject1/playing.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();
  bool isplaying = false;

  @override
  void initState() {
    // TODO: implement initState
    player.open(Audio('assets/audio/song2.mp3'),
        autoStart: false, showNotification: true);

    // player.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Column(
        children: [
          player.builderRealtimePlayingInfos(
              builder: (context, RealtimePlayingInfos? infos) {
            if (infos == null) {
              return SizedBox();
            }
            return PositionSeekWidget(
              currentPosition: infos.currentPosition,
              duration: infos.duration,
              seekTo: (to) {
                player.seek(to);
              },
            );
          }),
          (isplaying == true)
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isplaying=false;
                    });
                    player.pause();

                  },
                  icon: (Icon(
                    CupertinoIcons.pause,
                    size: 50,
                  )))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isplaying=true;
                    });
                    player.play();
                  },
                  icon: (Icon(
                    CupertinoIcons.play,
                    size: 50,
                  ))),
        ],
      ),
    );
  }
}
