import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/decision/data/datasources/decision_local_datasource.dart';
import 'features/decision/data/models/decision_model.dart';
import 'features/decision/data/models/decision_result_model.dart';
import 'features/decision/presentation/providers/decision_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(DecisionModelAdapter());
  Hive.registerAdapter(DecisionResultModelAdapter());
  Hive.registerAdapter(DecisionCategoryAdapter());
  Hive.registerAdapter(PurchaseTypeAdapter());
  Hive.registerAdapter(PaymentTypeAdapter());
  Hive.registerAdapter(DecisionStatusAdapter());

  final localDatasource = await DecisionLocalDataSource.create();

  runApp(
    ProviderScope(
      overrides: [
        decisionLocalDataSourceProvider.overrideWithValue(localDatasource),
      ],
      child: const SmartFinancialAdvisorApp(),
    ),
  );
}

class SmartFinancialAdvisorApp extends StatelessWidget {
  const SmartFinancialAdvisorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Financial Decision Advisor',
      theme: AppTheme.light(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: '/',
    );
  }
}
