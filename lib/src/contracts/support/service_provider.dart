import '../../foundation/magic.dart';

abstract class ServiceProvider {
  /// Bootstrap any application services.
  void boot(Magic magic);

  /// Register any application services.
  void register(Magic magic);
}