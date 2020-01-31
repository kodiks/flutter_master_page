import 'package:flutter/material.dart';

class InnerPage extends StatefulWidget {
  final String title;
  final Color color;

  const InnerPage({Key key, this.title, this.color}) : super(key: key);
  @override
  _InnerPageState createState() => _InnerPageState();
}

class _InnerPageState extends State<InnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} Inner Page"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: widget.color,
      ),
    );
  }
}
