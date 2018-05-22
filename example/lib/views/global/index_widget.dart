import 'package:app/app/models/user.dart';
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
    User user = await new User().find('skHSFN0A73R4U94QpU7TciiKMxU2');
    print(user);

    user.set('name', 'Anilcan Cakir');
    await user.save();

    print(user);

    fetchModels((data) => new User().make(data)).then(print);
  }
}