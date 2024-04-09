import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaboosterproject1/main.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 1), () {

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Txt',)), (route) => false);
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(title: 'title')));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              child: Image(image: AssetImage('assets/image/image.jpg'),fit: BoxFit.fitHeight,)),
          Center(child: Image(image: AssetImage('assets/image/image-removebg-preview (1).png')))
        ],
      ),
    );
  }
}
