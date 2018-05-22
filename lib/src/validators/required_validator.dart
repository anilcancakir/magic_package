import 'package:flutter/widgets.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String key() {
    return 'required';
  }

  @override
  String validate(BuildContext context, Object value, String attribute) {
    if (value is String && value.length > 0) {
      return null;
    }

    if (value != null) {
      return null;
    }

    return this.message(context, attribute);
  }
}