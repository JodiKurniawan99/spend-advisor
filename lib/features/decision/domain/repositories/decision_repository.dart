import '../entities/decision_input.dart';
import '../entities/purchase_decision.dart';

abstract class DecisionRepository {
  Future<List<PurchaseDecision>> getDecisions();

  Future<PurchaseDecision> addDecision(DecisionInput input);
}
