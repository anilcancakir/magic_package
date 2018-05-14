import '../config/magic_config.dart';
import '../contracts/auth/guard.dart';
import '../foundation/magic.dart';

class Auth {
  final Magic _magic;
  Guard _guard;

  Auth(this._magic);

  Guard get guard {
    if (this._guard == null) {
      this._guard = this.availableGuards[
        this._magic.make<MagicConfig>().get('confug.default')
      ];
    }

    return this._guard;
  }

  Map<String, Guard> get availableGuards {
    return this._magic.make<MagicConfig>().get('config.guards');
  }
}