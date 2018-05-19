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
    );
  }

  void test() async {
    User user = await new User().find('skHSFN0A73R4U94QpU7TciiKMxU2');
    user.set('name', 'Anil');
    print(
      await user.save()
    );

    print(
      await user.refresh()
    );
  }
}