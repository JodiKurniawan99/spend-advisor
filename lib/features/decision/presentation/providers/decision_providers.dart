import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/decision_local_datasource.dart';
import '../../data/repositories/decision_repository_impl.dart';
import '../../domain/entities/purchase_decision.dart';
import '../../domain/repositories/decision_repository.dart';
import '../../domain/services/decision_engine.dart';
import '../../domain/services/financial_health_calculator.dart';
import '../../domain/usecases/add_decision_usecase.dart';
import '../../domain/usecases/get_decisions_usecase.dart';
import '../notifiers/decision_form_notifier.dart';
import '../notifiers/decision_form_state.dart';
import '../notifiers/decision_list_notifier.dart';

final decisionLocalDataSourceProvider = Provider<DecisionLocalDataSource>((ref) {
  throw UnimplementedError('Override decisionLocalDataSourceProvider in main.dart');
});

final decisionRepositoryProvider = Provider<DecisionRepository>((ref) {
  final local = ref.watch(decisionLocalDataSourceProvider);
  return DecisionRepositoryImpl(local, const DecisionEngine());
});

final addDecisionUsecaseProvider = Provider<AddDecisionUseCase>((ref) {
  return AddDecisionUseCase(ref.watch(decisionRepositoryProvider));
});

final getDecisionsUsecaseProvider = Provider<GetDecisionsUseCase>((ref) {
  return GetDecisionsUseCase(ref.watch(decisionRepositoryProvider));
});

final decisionListProvider = StateNotifierProvider<DecisionListNotifier,
    AsyncValue<List<PurchaseDecision>>>((ref) {
  return DecisionListNotifier(ref.watch(getDecisionsUsecaseProvider));
});

final decisionFormNotifierProvider =
    StateNotifierProvider<DecisionFormNotifier, DecisionFormState>((ref) {
  return DecisionFormNotifier(ref.watch(addDecisionUsecaseProvider));
});

final financialHealthCalculatorProvider = Provider<FinancialHealthCalculator>((ref) {
  return const FinancialHealthCalculator();
});
