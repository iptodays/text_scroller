library text_scroller;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TextScrollController {
  _TextScrollerState state;
  add(String text) {
    if (state == null) return;
    state.update(text);
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
    this.scrollSpeed = const Duration(milliseconds: 500),
    this.textRemovalSpeed = const Duration(seconds: 10),
    this.pushUp = false,
  }) {
    // controller.state = _state;
  }

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

  /// [pushUp] pushes up texts if there is empty lines above.
  final bool pushUp;

  @override
  _TextScrollerState createState() => _TextScrollerState();
}

class _TextScrollerState extends State<TextScroller> {
  bool animate = false;
  List<String> texts = [];

  int removalCount = 0;

  final listController = ScrollController();
  update(String text) {
    if (mounted) {
      int len = texts.length;
      texts.add(text);
      setState(() {});
      scrollUp();

      Timer(widget.textRemovalSpeed, () {
        if (mounted) {
          if (widget.pushUp)
            texts.removeAt(0);
          else
            texts[len] = '';

          removalCount++;

          // print('text.length: ${texts.length}, removalCount: $removalCount');
          setState(() {});
        }
      });
    }
  }

  scrollUp() {
    Timer(
        Duration(milliseconds: 50),
        () => listController.animateTo(listController.position.maxScrollExtent,
            duration: widget.scrollSpeed, curve: Curves.ease));
  }

  @override
  void initState() {
    super.initState();
    widget.controller.state = this;
  }

  @override
  Widget build(BuildContext context) {
    return removalCount == texts.length
        ? SizedBox.shrink()
        : Container(
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.text == ''
        ? SizedBox.shrink()
        : Container(
            constraints: BoxConstraints(maxWidth: widget.width),
            padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              widget.text,
              style: widget.style,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
  }
}
