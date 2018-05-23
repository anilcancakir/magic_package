import 'package:flutter/material.dart';
import 'package:magic/magic.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginWidgetState();
  }
}

class _LoginData {
  String email;
  String password;
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  void _submit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showLoader(context);

      try {
        bool success = await guard().attempt({
          'email': this._data.email,
          'password': this._data.password
        });

        if (success) {
          hideLoader(context);
        } else {
          showError(context, trans(context, 'auth.failed'));
        }
      } on ApiException catch (e) {
        showError(context, e.getFirstError());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          trans(context, 'auth.login')
        ),
      ),
      body: new Form(
        key: this._formKey,
        child: new FormList(
          items: [
            new FormItem(
              input: new Input(
                name: 'email',
                type: InputType.email,
                onSaved: (String value) => this._data.email = value,
                validators: [
                  new RequiredValidator(),
                  new EmailValidator()
                ],
              ),
            ),
            new FormItem(
              input: new Input(
                name: 'password',
                type: InputType.password,
                onSaved: (String value) => this._data.password = value,
                validators: [
                  new RequiredValidator()
                ],
              ),
            ),
            new FormItem(
              input: new RaisedButton(
                child: new Text(trans(context, 'auth.login')),
                onPressed: () => this._submit(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}