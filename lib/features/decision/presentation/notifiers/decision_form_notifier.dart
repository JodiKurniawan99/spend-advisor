import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/decision_enums.dart';
import '../../domain/entities/decision_input.dart';
import '../../domain/entities/purchase_decision.dart';
import '../../domain/usecases/add_decision_usecase.dart';
import 'decision_form_state.dart';

class DecisionFormNotifier extends StateNotifier<DecisionFormState> {
  DecisionFormNotifier(this._addDecisionUseCase) : super(const DecisionFormState());

  final AddDecisionUseCase _addDecisionUseCase;

  void updateItemName(String value) =>
      state = state.copyWith(itemName: value, clearError: true);

  void updatePrice(String value) =>
      state = state.copyWith(price: double.tryParse(value), clearError: true);

  void updateCategory(DecisionCategory value) =>
      state = state.copyWith(category: value, clearError: true);

  void updateUrgency(double value) =>
      state = state.copyWith(urgencyLevel: value.toInt(), clearError: true);

  void updateType(PurchaseType value) =>
      state = state.copyWith(type: value, clearError: true);

  void updatePaymentType(PaymentType value) =>
      state = state.copyWith(paymentType: value, clearError: true);

  void updateMonthlyIncome(String value) =>
      state = state.copyWith(monthlyIncome: double.tryParse(value), clearError: true);

  void updateCurrentSavings(String value) =>
      state = state.copyWith(currentSavings: double.tryParse(value), clearError: true);

  void updateMonthlyExpense(String value) =>
      state = state.copyWith(monthlyExpense: double.tryParse(value), clearError: true);

  Future<PurchaseDecision?> submit() async {
    if (!state.isValid) {
      state = state.copyWith(errorMessage: 'Please fill all fields with valid values.');
      return null;
    }

    state = state.copyWith(isSubmitting: true, clearError: true);

    try {
      final input = DecisionInput(
        itemName: state.itemName,
        price: state.price!,
        category: state.category,
        urgencyLevel: state.urgencyLevel,
        type: state.type,
        paymentType: state.paymentType,
        monthlyIncome: state.monthlyIncome!,
        currentSavings: state.currentSavings!,
        monthlyExpense: state.monthlyExpense!,
      );

      final decision = await _addDecisionUseCase(input);
      state = const DecisionFormState();
      return decision;
    } catch (_) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to save decision. Try again.',
      );
      return null;
    }
  }
}
