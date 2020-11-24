import 'package:expense_manager/src/home/blocs/home/home_bloc.dart';
import 'package:expense_manager/src/home/services/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<HomeBloc>(
    lazy: false,
    create: (dynamic context) =>
        HomeBloc(RepositoryProvider.of<HomeService>(context)),
  )
];

final KiwiContainer kiwiContainer = KiwiContainer();

List<RepositoryProvider> repositoryProviders = [
  RepositoryProvider<HomeService>(
    create: (context) => kiwiContainer.resolve<HomeService>(),
  ),
];
