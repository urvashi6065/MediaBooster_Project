import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaboosterproject1/modelClass.dart';
import 'package:mediaboosterproject1/provider.dart';
import 'package:mediaboosterproject1/videoDetail.dart';
import 'package:provider/provider.dart';

class videoscreen extends StatefulWidget {
  const videoscreen({Key? key}) : super(key: key);

  @override
  State<videoscreen> createState() => _videoscreenState();
}

class _videoscreenState extends State<videoscreen> {
  @override
  Widget build(BuildContext context) {
    final providerVar=Provider.of<ProviderClass>(context,listen: true);
    return ListView.builder(
        itemCount: providerVar.videoList.length,
        itemBuilder: (context, int index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>videodetail(url: providerVar.videoList[index].url,)));
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 120,
                        width: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),image: DecorationImage(image: AssetImage(providerVar.videoList[index].image!),fit: BoxFit.fill)),
                        // child: Image(image: AssetImage(videoList[index].image!),fit: BoxFit.fill,),
                      ),
                      Expanded(
                          child: Container(
                              height: 120,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  providerVar.videoList[index].songName!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )))
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
