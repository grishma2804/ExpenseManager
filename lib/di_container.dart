
import 'package:dio/dio.dart';
import 'package:expense_manager/src/commons/services/navigation_service.dart';
import 'package:expense_manager/src/wallet/services/api.dart';
import 'package:expense_manager/src/wallet/services/wallet_service.dart';
import 'package:kiwi/kiwi.dart';
part 'di_container.g.dart';

abstract class Injector {
  @Register.singleton(APIService)
  @Register.singleton(NavigationService)
  @Register.singleton(WalletService)

  void configure();
}

void setup() {
  var injector = _$Injector();
  injector.configure();
}
