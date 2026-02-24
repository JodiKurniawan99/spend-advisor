import 'decision_enums.dart';
import 'decision_result.dart';

class PurchaseDecision {
  const PurchaseDecision({
    required this.id,
    required this.itemName,
    required this.price,
    required this.category,
    required this.urgencyLevel,
    required this.type,
    required this.paymentType,
    required this.monthlyIncome,
    required this.currentSavings,
    required this.monthlyExpense,
    required this.result,
    required this.createdAt,
  });

  final String id;
  final String itemName;
  final double price;
  final DecisionCategory category;
  final int urgencyLevel;
  final PurchaseType type;
  final PaymentType paymentType;
  final double monthlyIncome;
  final double currentSavings;
  final double monthlyExpense;
  final DecisionResult result;
  final DateTime createdAt;
}
