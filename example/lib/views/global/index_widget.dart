import 'package:flutter/material.dart';
import 'package:magic/magic.dart';

class IndexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(
        config('app.name')
      )),
    );
  }
}