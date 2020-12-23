# Text scroller

A highly customizable text scrolling widget. You can customize all the aspects.

![Text Scroller](https://raw.githubusercontent.com/thruthesky/text_scroller/main/text_scroller.gif)
![Text Scroller](https://raw.githubusercontent.com/thruthesky/text_scroller/main/text_scroller_4.gif)

```dart
final textScrollController = TextScrollController();

textScrollController.add('So, This is no. $c');

TextScroller(
  controller: textScrollController,
  style: TextStyle(fontSize: 11),
  height: 242,
  width: 260,
  lineHeight: 20,
  backgroundColor: Color(0x44cccccc),
  textRemovalSpeed: Duration(seconds: 3),
);
```
