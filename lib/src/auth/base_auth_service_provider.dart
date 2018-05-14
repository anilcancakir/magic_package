import 'package:magic/src/foundation/magic.dart';

import '../config/magic_config.dart';
import '../contracts/support/service_provider.dart';
import 'auth.dart';

class BaseAuthServiceProvider extends ServiceProvider {
  Map<String, dynamic> config = new Map<String, dynamic>();

  @override
  void boot(Magic magic) {

  }

  @override
  void register(Magic magic) {
    // Set config
    this.config.forEach((String key, dynamic value) => magic.make<MagicConfig>().set('auth.$key', value));

    // Singleton auth instance
    magic.singleton<Auth>((Magic magic) => new Auth(magic));
  }
}