/*
 * @Author: A kingiswinter@gmail.com
 * @Date: 2024-12-30 10:50:24
 * @LastEditors: A kingiswinter@gmail.com
 * @LastEditTime: 2024-12-30 10:52:30
 * @FilePath: /text_scroller/example/lib/main.dart
 * 
 * Copyright (c) 2024 by A kingiswinter@gmail.com, All Rights Reserved.
 */
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:text_scroller/text_scroller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textScrollController = TextScrollController();
  int c = 0;
  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 1500), (timer) {
      c++;
      if (c > 10 && c < 30) {
        if (Random().nextInt(5) != 0) return;

        textScrollController.add(Text('Okay, then, This is no. $c'));
      } else {
        if (Random().nextBool()) {
          textScrollController
              .add(Text('So, what if the line is very long. This is no. $c'));
        } else {
          textScrollController.add(Text('So, This is no. $c'));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextScroller(
              controller: textScrollController,
              backgroundColor: Color(0x88cccccc),
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
