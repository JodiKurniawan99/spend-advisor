import '../../domain/entities/decision_input.dart';
import '../../domain/entities/purchase_decision.dart';
import '../../domain/repositories/decision_repository.dart';
import '../../domain/services/decision_engine.dart';
import '../datasources/decision_local_datasource.dart';
import '../models/decision_model.dart';

class DecisionRepositoryImpl implements DecisionRepository {
  const DecisionRepositoryImpl(this._localDataSource, this._decisionEngine);

  final DecisionLocalDataSource _localDataSource;
  final DecisionEngine _decisionEngine;

  @override
  Future<PurchaseDecision> addDecision(DecisionInput input) async {
    final result = _decisionEngine.evaluate(
      price: input.price,
      type: input.type,
      urgencyLevel: input.urgencyLevel,
      monthlyIncome: input.monthlyIncome,
      currentSavings: input.currentSavings,
      monthlyExpense: input.monthlyExpense,
    );

    final entity = PurchaseDecision(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      itemName: input.itemName,
      price: input.price,
      category: input.category,
      urgencyLevel: input.urgencyLevel,
      type: input.type,
      paymentType: input.paymentType,
      monthlyIncome: input.monthlyIncome,
      currentSavings: input.currentSavings,
      monthlyExpense: input.monthlyExpense,
      result: result,
      createdAt: DateTime.now(),
    );

    final model = DecisionModel.fromEntity(entity);
    await _localDataSource.addDecision(model);
    return entity;
  }

  @override
  Future<List<PurchaseDecision>> getDecisions() async {
    return _localDataSource.getDecisions().map((model) => model.toEntity()).toList();
  }
}
