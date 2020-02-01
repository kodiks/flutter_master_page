import 'package:example/app/generic_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:master_page/master_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Page Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Master Page Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> innerPageColors = [
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
  ];
  @override
  Widget build(BuildContext context) {
    return MasterPageWidget(
      appPages: [
        AppPage(
          name: "home",
          title: "Home",
          icon: Icons.home,
          route: MaterialPageRoute(
            builder: (context) {
              return GenericPage(
                title: "Home",
                innerPagecolor: innerPageColors[0],
              );
            },
          ),
        ),
        AppPage(
          name: "product",
          title: "Product",
          icon: Icons.list,
          route: MaterialPageRoute(
            builder: (context) {
              return GenericPage(
                title: "Product",
                innerPagecolor: innerPageColors[1],
              );
            },
          ),
        ),
        AppPage(
          name: "cart",
          title: "Cart",
          icon: Icons.shopping_cart,
          route: MaterialPageRoute(
            builder: (context) {
              return GenericPage(
                title: "Cart",
                innerPagecolor: innerPageColors[2],
              );
            },
          ),
        ),
        AppPage(
          name: "settings",
          title: "Settings",
          icon: Icons.settings_applications,
          route: MaterialPageRoute(
            builder: (context) {
              return GenericPage(
                title: "Settings",
                innerPagecolor: innerPageColors[3],
              );
            },
          ),
        ),
      ],
      firstPageName: "home",
    );
  }
}
