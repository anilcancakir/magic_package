import 'package:flutter/material.dart';
import 'package:magic/magic.dart';

class IndexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    this.test();

    return new Scaffold(
      appBar: new AppBar(title: new Text(
        config('app.name')
      )),
      body: new Container(
        child: new Center(
          child: new Text(trans(context, 'hello_world')),
        ),
      ),
    );
  }

  void test() async {
    print(auth().check());
    print(auth().user());

//    print({
//      'attempt': await guard().attempt({'email': 'foo@bar.com', 'password': 'secretpassword'})
//    });
  }
}