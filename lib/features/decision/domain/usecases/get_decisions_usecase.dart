import '../entities/purchase_decision.dart';
import '../repositories/decision_repository.dart';

class GetDecisionsUseCase {
  const GetDecisionsUseCase(this._repository);

  final DecisionRepository _repository;

  Future<List<PurchaseDecision>> call() {
    return _repository.getDecisions();
  }
}
