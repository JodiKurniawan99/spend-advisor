import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/purchase_decision.dart';
import '../providers/decision_providers.dart';
import '../widgets/status_badge.dart';

class DecisionDetailPage extends ConsumerWidget {
  const DecisionDetailPage({super.key, required this.decision});

  final PurchaseDecision decision;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final health = ref.watch(financialHealthCalculatorProvider).calculate(
          income: decision.monthlyIncome,
          savings: decision.currentSavings,
          expense: decision.monthlyExpense,
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Decision Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(decision.itemName, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Price: ${NumberFormat.currency(symbol: '\$').format(decision.price)}'),
                  Text('Category: ${decision.category.name}'),
                  Text('Type: ${decision.type.name}'),
                  Text('Payment: ${decision.paymentType.name}'),
                  Text('Urgency: ${decision.urgencyLevel}/5'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Evaluation'),
                  const SizedBox(height: 8),
                  StatusBadge(status: decision.result.status),
                  const SizedBox(height: 8),
                  Text(decision.result.message),
                  Text('Impact: ${decision.result.impactPercentage.toStringAsFixed(1)}% of income'),
                  Text('Financial Health Score: $health / 100'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
