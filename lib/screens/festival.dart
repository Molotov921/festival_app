// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:festival_app/utils/global.dart';

class Festival extends StatefulWidget {
  const Festival({super.key});

  @override
  State<Festival> createState() => _FestivalState();
}

class _FestivalState extends State<Festival> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Festival List',
          style: TextStyle(fontFamily: 'font4'),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: Global.festivalData.map(
          (e) {
            return Container(
              margin: EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('fest_design', arguments: e);
                },
                child: Card(
                  elevation: 8,
                  child: Container(
                    alignment: Alignment(0, 0),
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            height: 100,
                            width: 100,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image(
                                image: NetworkImage('${e['img']}'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '${e['festival']}',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 30,
                                  fontFamily: 'font7'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
