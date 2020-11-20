// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'di_container.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => APIService(c<Dio>()));
    container.registerSingleton((c) => NavigationService());
    container.registerSingleton((c) => WalletService(c<APIService>()));
  }
}
