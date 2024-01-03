import 'package:flutter/material.dart';

import 'api_page.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Material App Bar'),
        // ),
       // body: DemoAPI(),)
        body: HomePage(),
      )
    );
  }
}
