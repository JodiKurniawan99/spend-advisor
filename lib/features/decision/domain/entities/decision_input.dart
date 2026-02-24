import 'decision_enums.dart';

class DecisionInput {
  const DecisionInput({
    required this.itemName,
    required this.price,
    required this.category,
    required this.urgencyLevel,
    required this.type,
    required this.paymentType,
    required this.monthlyIncome,
    required this.currentSavings,
    required this.monthlyExpense,
  });

  final String itemName;
  final double price;
  final DecisionCategory category;
  final int urgencyLevel;
  final PurchaseType type;
  final PaymentType paymentType;
  final double monthlyIncome;
  final double currentSavings;
  final double monthlyExpense;
}
