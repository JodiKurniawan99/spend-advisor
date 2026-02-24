import '../entities/decision_enums.dart';
import '../entities/decision_result.dart';

class DecisionEngine {
  const DecisionEngine();

  DecisionResult evaluate({
    required double price,
    required PurchaseType type,
    required int urgencyLevel,
    required double monthlyIncome,
    required double currentSavings,
    required double monthlyExpense,
  }) {
    final double impactPercentage =
        monthlyIncome == 0 ? 100 : ((price / monthlyIncome) * 100).clamp(0, 999);

    final bool highRisk = price > 0.3 * monthlyIncome;
    final bool lowEmergencyFund = currentSavings < 3 * monthlyExpense;
    final bool shouldWait = type == PurchaseType.want && urgencyLevel <= 2;

    if (highRisk || (lowEmergencyFund && shouldWait)) {
      return DecisionResult(
        status: DecisionStatus.risky,
        message:
            'This purchase may put pressure on your finances. Consider postponing it.',
        impactPercentage: impactPercentage,
      );
    }

    if (lowEmergencyFund || shouldWait) {
      return DecisionResult(
        status: DecisionStatus.consider,
        message:
            'You can proceed with caution, but reviewing your budget first is recommended.',
        impactPercentage: impactPercentage,
      );
    }

    return DecisionResult(
      status: DecisionStatus.safe,
      message: 'This purchase looks financially manageable right now.',
      impactPercentage: impactPercentage,
    );
  }
}
