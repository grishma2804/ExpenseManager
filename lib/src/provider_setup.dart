
import 'package:expense_manager/src/wallet/blocs/wallet/wallet_bloc.dart';
import 'package:expense_manager/src/wallet/services/api.dart';
import 'package:expense_manager/src/wallet/services/wallet_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';


List<BlocProvider> blocProviders = [
  BlocProvider<WalletBloc>(
    lazy: false,
    create: (dynamic context) => WalletBloc(
        RepositoryProvider.of<WalletService>(context)),
  )
];

final KiwiContainer kiwiContainer = KiwiContainer();

List<RepositoryProvider> repositoryProviders = [
  RepositoryProvider<APIService>(
    create: (context) => kiwiContainer.resolve<APIService>(),
  ),
  RepositoryProvider<WalletService>(
    create: (context) => kiwiContainer.resolve<WalletService>(),
  ),

];