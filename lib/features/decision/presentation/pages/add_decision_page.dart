import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/decision_enums.dart';
import '../providers/decision_providers.dart';

class AddDecisionPage extends ConsumerWidget {
  const AddDecisionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(decisionFormNotifierProvider);
    final notifier = ref.read(decisionFormNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Purchase Decision')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _textField('Item Name', notifier.updateItemName),
          _textField('Price', notifier.updatePrice, numeric: true),
          _dropdownField<DecisionCategory>(
            label: 'Category',
            value: state.category,
            items: DecisionCategory.values,
            onChanged: notifier.updateCategory,
          ),
          const SizedBox(height: 12),
          Text('Urgency Level (${state.urgencyLevel})'),
          Slider(
            min: 1,
            max: 5,
            divisions: 4,
            value: state.urgencyLevel.toDouble(),
            onChanged: notifier.updateUrgency,
          ),
          _dropdownField<PurchaseType>(
            label: 'Type',
            value: state.type,
            items: PurchaseType.values,
            onChanged: notifier.updateType,
          ),
          _dropdownField<PaymentType>(
            label: 'Payment Type',
            value: state.paymentType,
            items: PaymentType.values,
            onChanged: notifier.updatePaymentType,
          ),
          _textField('Monthly Income', notifier.updateMonthlyIncome, numeric: true),
          _textField('Current Savings', notifier.updateCurrentSavings, numeric: true),
          _textField('Monthly Expense', notifier.updateMonthlyExpense, numeric: true),
          if (state.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: state.isSubmitting
                ? null
                : () async {
                    final result = await notifier.submit();
                    if (result != null && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
            child: state.isSubmitting
                ? const CircularProgressIndicator()
                : const Text('Evaluate & Save'),
          ),
        ],
      ),
    );
  }

  Widget _textField(
    String label,
    ValueChanged<String> onChanged, {
    bool numeric = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        keyboardType: numeric ? const TextInputType.numberWithOptions(decimal: true) : null,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dropdownField<T extends Enum>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item.name)))
            .toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }
}
