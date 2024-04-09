import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaboosterproject1/Favoritescreen.dart';
import 'package:mediaboosterproject1/provider.dart';
import 'package:provider/provider.dart';

import 'AudioScareen.dart';
import 'SplashScareen.dart';
import 'Videoscareen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ProviderClass())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: splashscreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: scaffoldkey,
        drawerEnableOpenDragGesture: true,
        drawer: Drawer(),
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
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Music Player',
                          style: TextStyle(
                              color: CupertinoColors.white, fontSize: 20),
                        ),
                        PopupMenuButton(
                            iconColor: Colors.white,
                            itemBuilder: (BuildContext contect) => [
                                  PopupMenuItem(
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FavoriteScrren()));
                                            // Navigator.of(context).pop();
                                          },
                                          child: Text('Favorite')))
                                ])
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TabBar(
                      labelColor: CupertinoColors.white,
                      // automaticIndicatorColorAdjustment: false,
                      enableFeedback: false,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Text(
                          'Audio',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Video',
                          style: TextStyle(fontSize: 18),
                        ),
                        // Text('Favorite',style: TextStyle(fontSize: 18),)
                      ]),
                  Expanded(
                    child: TabBarView(children: [
                      audioScreen(),
                      videoscreen(),
                      // FavoriteScrren()
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
