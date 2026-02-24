import '../../domain/entities/decision_enums.dart';

class DecisionFormState {
  const DecisionFormState({
    this.itemName = '',
    this.price,
    this.category = DecisionCategory.other,
    this.urgencyLevel = 3,
    this.type = PurchaseType.need,
    this.paymentType = PaymentType.cash,
    this.monthlyIncome,
    this.currentSavings,
    this.monthlyExpense,
    this.isSubmitting = false,
    this.errorMessage,
  });

  final String itemName;
  final double? price;
  final DecisionCategory category;
  final int urgencyLevel;
  final PurchaseType type;
  final PaymentType paymentType;
  final double? monthlyIncome;
  final double? currentSavings;
  final double? monthlyExpense;
  final bool isSubmitting;
  final String? errorMessage;

  bool get isValid =>
      itemName.trim().isNotEmpty &&
      (price ?? 0) > 0 &&
      (monthlyIncome ?? 0) > 0 &&
      (currentSavings ?? -1) >= 0 &&
      (monthlyExpense ?? 0) >= 0;

  DecisionFormState copyWith({
    String? itemName,
    double? price,
    DecisionCategory? category,
    int? urgencyLevel,
    PurchaseType? type,
    PaymentType? paymentType,
    double? monthlyIncome,
    double? currentSavings,
    double? monthlyExpense,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DecisionFormState(
      itemName: itemName ?? this.itemName,
      price: price ?? this.price,
      category: category ?? this.category,
      urgencyLevel: urgencyLevel ?? this.urgencyLevel,
      type: type ?? this.type,
      paymentType: paymentType ?? this.paymentType,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      currentSavings: currentSavings ?? this.currentSavings,
      monthlyExpense: monthlyExpense ?? this.monthlyExpense,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
