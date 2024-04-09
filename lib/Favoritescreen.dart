import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaboosterproject1/modelClass.dart';
import 'package:mediaboosterproject1/provider.dart';
import 'package:provider/provider.dart';

class FavoriteScrren extends StatefulWidget {

  const FavoriteScrren({Key? key,}) : super(key: key);

  @override
  State<FavoriteScrren> createState() => _FavoriteScrrenState();
}

class _FavoriteScrrenState extends State<FavoriteScrren> {

  @override
  Widget build(BuildContext context) {
    final providerVar=Provider.of<ProviderClass>(context,listen: true);
    return Scaffold(
      // appBar: AppBar(),
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
                  // print('Onprint');
                   Navigator.of(context).pop();
                   Navigator.of(context).pop();
                }, icon: Icon(CupertinoIcons.back,size: 30,color: Colors.white,)),
                SizedBox(width: 30,),
                Text('Your Favorite',style: TextStyle(color: Colors.white,fontSize: 20),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: (providerVar.Favoritelist.isEmpty)?Center(child: Text('No Fav Songs...',style: TextStyle(color: Colors.white),)):ListView.builder(
                itemCount: providerVar.Favoritelist                                                                                                                                                                        .length,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: Container(
                      height: 50,
                      width: 55,
                      decoration: BoxDecoration(
                          color: Colors.red,

                          borderRadius: BorderRadius.circular(10),

                          image: DecorationImage(image: AssetImage(providerVar.Favoritelist[index].image!),fit: BoxFit.fill)),
                    ),
                    title: Text(providerVar.Favoritelist[index].Songname!,style: TextStyle(color: Colors.white),),
                    subtitle: Text(providerVar.Favoritelist[index].singerName!,style: TextStyle(color: Colors.white),),
                    trailing: IconButton(onPressed: () {
                      // setState(() {
                      //   // Favoritelist.removeAt(index);
                      // });
                      providerVar.getFavoriteDelate(index);
                    }, icon: Icon(Icons.close,color: Colors.white,),),
                  );
                }),
          ),
        ],
        ),
    );
  }
}
