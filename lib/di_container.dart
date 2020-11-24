import 'package:expense_manager/src/commons/services/navigation_service.dart';
import 'package:expense_manager/src/home/services/home_service.dart';
import 'package:kiwi/kiwi.dart';

part 'di_container.g.dart';

abstract class Injector {
  @Register.singleton(NavigationService)
  @Register.singleton(HomeService)
  void configure();
}

void setupDI() {
  var injector = _$Injector();
  injector.configure();
}
