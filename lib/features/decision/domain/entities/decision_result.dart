import 'decision_enums.dart';

class DecisionResult {
  const DecisionResult({
    required this.status,
    required this.message,
    required this.impactPercentage,
  });

  final DecisionStatus status;
  final String message;
  final double impactPercentage;
}
