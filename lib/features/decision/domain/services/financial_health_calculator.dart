class FinancialHealthCalculator {
  const FinancialHealthCalculator();

  int calculate({
    required double income,
    required double savings,
    required double expense,
  }) {
    if (income <= 0) {
      return 0;
    }

    final double savingsRatio = savings / income;
    final double expenseRatio = expense / income;
    final bool noEmergencyFund = savings < 3 * expense;

    int score = 100;

    if (savingsRatio < 0.2) score -= 20;
    if (expenseRatio > 0.7) score -= 20;
    if (noEmergencyFund) score -= 30;

    return score.clamp(0, 100);
  }
}
