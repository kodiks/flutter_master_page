import 'package:example/app/innter_page.dart';
import 'package:flutter/material.dart';

class GenericPage extends StatefulWidget {
  final String title;
  final Color innerPagecolor;

  const GenericPage({Key key, this.title, this.innerPagecolor}) : super(key: key);
  @override
  _GenericPageState createState() => _GenericPageState();
}

class _GenericPageState extends State<GenericPage> {
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
            Container(
              child: Text(widget.title + " Description"),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              child: Text("Go To Inner Page"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return InnerPage(
                        title: widget.title,
                        color: widget.innerPagecolor,
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
