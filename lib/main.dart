import 'package:expense_manager/src/app.dart';
import 'package:expense_manager/src/home/models/budget.dart';
import 'package:expense_manager/src/home/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHiveBox();
  setupDI();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}

Future setupHiveBox() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(BudgetAdapter());
}
