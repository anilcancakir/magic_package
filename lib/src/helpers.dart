import 'auth/auth.dart';
import 'config/magic_config.dart';
import 'contracts/auth/guard.dart';
import 'foundation/magic.dart';

/// Resolve the given type from the magic.
T make<T>() {
  return Magic.getInstance().make<T>();
}

/// Get the specified configuration value.
dynamic config(String key) {
  return make<MagicConfig>().get(key);
}

/// Get the active auth guard.
Guard guard() {
  return make<Auth>().guard;
}