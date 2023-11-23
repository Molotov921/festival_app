// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:festival_app/utils/global.dart';
import 'package:share_extend/share_extend.dart';

class Fest_Design extends StatefulWidget {
  const Fest_Design({super.key});

  @override
  State<Fest_Design> createState() => _Fest_DesignState();
}

class _Fest_DesignState extends State<Fest_Design> {
  Color chooseColor = Colors.black;
  String chooseFonts = '';
  Color chooseBackGroundColor = Colors.white;
  String chooseImage = '';
  double fontSize = 25;

  TextEditingController festQuoteController = TextEditingController();
  GlobalKey repaintBoundry = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    void shareImage() async {
      RenderRepaintBoundary renderRepaintBoundary =
          repaintBoundry.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      var image = await renderRepaintBoundary.toImage(pixelRatio: 5);

      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

      Uint8List fetchImage = byteData!.buffer.asUint8List();

      Directory directory = await getApplicationCacheDirectory();

      String path = directory.path;

      File file = File('$path.png');

      file.writeAsBytes(fetchImage);

      ShareExtend.share(file.path, "Image");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${data['festival']} Post Design',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'font6'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              shareImage();
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  chooseColor = Colors.black;
                  chooseBackGroundColor = Colors.white;
                  chooseImage = '';
                  chooseFonts = '';
                  Global.fest_quote = 'Press + To Add Quote';
                });
              },
              icon: const Icon(Icons.restart_alt)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Add Quote',
                ),
                content: TextField(
                  controller: festQuoteController,
                  decoration: InputDecoration(
                    hintText: 'Enter Quote',
                  ),
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Global.fest_quote = festQuoteController.text;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text('Done'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      // Body.............................................................
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // Design.............................................................
            RepaintBoundary(
              key: repaintBoundry,
              child: Card(
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  height: 400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: chooseBackGroundColor,
                    image: DecorationImage(
                      image: AssetImage('assets/img/$chooseImage'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    Global.fest_quote,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: chooseColor,
                      fontFamily: chooseFonts,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Background Image",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 12),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: (data['images'] as List<String>).map(
                    (e) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            chooseImage = e;
                          });
                        },
                        child: Card(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage('assets/img/$e'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Label Color...................................................
            // Color ..........................
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Color",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: Colors.primaries.map(
                            (e) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    chooseColor = e;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: e,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // BackGround Color........................................
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Background Color",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: Colors.accents.map(
                            (e) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    chooseImage = '';
                                    chooseBackGroundColor = e;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: e,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Font Size ...................................................
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Font size",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: Global.textsSize.map(
                            (e) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    fontSize = e;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 80,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blueGrey),
                                  child: Text(
                                    '${e.toInt()}',
                                    style: TextStyle(
                                      fontSize: e,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Label Fonts
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    // color: Colors.brown,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Fonts",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      elevation: 0,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: Global.fonts.map(
                            (e) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    chooseFonts = e;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 50,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Fonts',
                                    style:
                                        TextStyle(fontSize: 22, fontFamily: e),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
