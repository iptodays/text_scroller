library text_scroller;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TextScrollController {
  _TextScrollerState state;
  add(String text) {
    state.texts.add(text);
    state.update();
    state.listController.animateTo(
        state.listController.position.maxScrollExtent,
        duration: state.widget.scrollSpeed,
        curve: Curves.ease);
  }
}

class TextScroller extends StatefulWidget {
  TextScroller({
    @required this.controller,
    this.width = 200,
    this.height = 82,
    this.lineHeight = 24,
    this.style = const TextStyle(fontSize: 12),
    this.backgroundColor = Colors.grey,
    this.scrollSpeed = const Duration(milliseconds: 200),
    this.textRemovalSpeed = const Duration(seconds: 10),
  }) {
    controller.state = _state;
  }
  final _TextScrollerState _state = _TextScrollerState();

  /// controller to add more texts.
  final TextScrollController controller;

  /// Text style of the line.
  final TextStyle style;

  /// [backgroundColor] of the text.
  final Color backgroundColor;

  /// [width] of the widget.
  final double width;

  /// [height] of the widget. The height should be adjusted with the combination of [lineHeight]
  final double height;

  /// [lineHeight] is the height of one line. Adjust height of the widget with [height].
  final double lineHeight;

  /// [scrollSpeed] sets how fast the text lines scroll up.
  final Duration scrollSpeed;

  /// [textRemovalSpeed] sets how long it should wait until it removes the text.
  final Duration textRemovalSpeed;

  @override
  _TextScrollerState createState() => _state;
}

class _TextScrollerState extends State<TextScroller> {
  bool animate = false;
  List<String> texts = [];

  final listController = ScrollController();
  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ListView(
        controller: listController,
        itemExtent: widget.lineHeight,
        addAutomaticKeepAlives: false,
        children: [
          for (final text in texts)
            Stack(
              children: [
                Positioned(
                  right: 0,
                  child: TextSticker(
                    text,
                    backgroundColor: widget.backgroundColor,
                    style: widget.style,
                    width: widget.width,
                    textRemovalSpeed: widget.textRemovalSpeed,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class TextSticker extends StatefulWidget {
  TextSticker(
    this.text, {
    this.style,
    this.backgroundColor,
    this.width,
    this.textRemovalSpeed,
  });
  final String text;
  final TextStyle style;
  final Color backgroundColor;
  final double width;
  final Duration textRemovalSpeed;
  @override
  _TextStickerState createState() => _TextStickerState();
}

class _TextStickerState extends State<TextSticker> {
  String text;

  @override
  void initState() {
    super.initState();

    text = widget.text;
    Timer(widget.textRemovalSpeed, () {
      text = '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: widget.width),
      padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
      decoration: BoxDecoration(
        color: text == '' ? Colors.transparent : widget.backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: widget.style,
        textAlign: TextAlign.right,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}