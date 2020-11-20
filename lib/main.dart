import 'package:dio/dio.dart';
import 'package:expense_manager/src/app.dart';
import 'package:expense_manager/src/wallet/models/expense.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:path_provider/path_provider.dart';

import 'di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHiveBox();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? null : await getApplicationDocumentsDirectory(),
  );
  final KiwiContainer kiwiContainer = KiwiContainer();

  final Dio dio = getDioInstance();
  kiwiContainer.registerInstance(dio);
  setup();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}

Future setupHiveBox() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
}

Dio getDioInstance() {
  final BaseOptions _baseOptions = BaseOptions(
    connectTimeout: 60 * 1000,
    receiveTimeout: 30 * 1000,
    // baseUrl: NetworkConstants.baseUrl
  );
  final Dio _dio = Dio(_baseOptions);
  return _dio;
}
