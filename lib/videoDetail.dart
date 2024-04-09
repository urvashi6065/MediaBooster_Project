import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaboosterproject1/provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class videodetail extends StatefulWidget {
  final String? url;
  const videodetail({Key? key, required this.url}) : super(key: key);

  @override
  State<videodetail> createState() => _videodetailState();
}

class _videodetailState extends State<videodetail> {


  @override
  void initState() {
    // TODO: implement initState
    final providerVar=Provider.of<ProviderClass>(context,listen: false);

    providerVar.playController = VideoPlayerController.asset(widget.url!);
    providerVar.playController!.initialize();
    providerVar.chewieController=ChewieController(fullScreenByDefault: true,videoPlayerController: providerVar.playController!,autoPlay: true,looping: true);
    super.initState();
  }
  @override
  void dispose() {
    final providerVar=Provider.of<ProviderClass>(context,listen: false);
    // TODO: implement dispose
    providerVar.playController?.dispose();
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
            child: Image(image: AssetImage('assets/image/image.jpg'),fit: BoxFit.fitHeight,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(CupertinoIcons.back,color: Colors.white,size: 30,)),
                SizedBox(width: 30,),
                Text('Now Playing',style: TextStyle(color: Colors.white,fontSize: 20),)
              ],
            ),
          ),
          Center(
            child: Container(
              height: 500,
              child: Chewie(controller: providerVar.chewieController!),
            ),
          ),
        ],
      ),
    );
  }
}
