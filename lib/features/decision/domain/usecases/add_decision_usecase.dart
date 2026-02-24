import '../entities/decision_input.dart';
import '../entities/purchase_decision.dart';
import '../repositories/decision_repository.dart';

class AddDecisionUseCase {
  const AddDecisionUseCase(this._repository);

  final DecisionRepository _repository;

  Future<PurchaseDecision> call(DecisionInput input) {
    return _repository.addDecision(input);
  }
}
