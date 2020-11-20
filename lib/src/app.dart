import 'package:expense_manager/src/commons/constants/app_colors.dart';
import 'package:expense_manager/src/commons/services/navigation_service.dart';
import 'package:expense_manager/src/provider_setup.dart';
import 'package:expense_manager/src/route_manager.dart';
import 'package:expense_manager/src/wallet/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(
        providers: blocProviders,
        child:  MaterialApp(
            title: 'Expense Manger',
            theme: ThemeData(
                fontFamily: 'Circular',
                primaryColor: AppColors.primary,
                accentColor: AppColors.primary,
                hintColor: AppColors.primary,
                buttonColor: AppColors.primary,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: AppColors.primaryBtnText),
            home: Wallet(),
            navigatorKey: KiwiContainer().resolve<NavigationService>().navigationKey,
            onGenerateRoute: RouteManager.generateRoute,
          ),
      ),
    );
  }
}
