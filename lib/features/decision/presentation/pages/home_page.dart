import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/purchase_decision.dart';
import '../providers/decision_providers.dart';
import '../widgets/status_badge.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decisionsAsync = ref.watch(decisionListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Smart Financial Decision Advisor')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/add');
          ref.read(decisionListProvider.notifier).load();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Decision'),
      ),
      body: decisionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (decisions) {
          if (decisions.isEmpty) {
            return const Center(
              child: Text('No decisions yet. Tap + to evaluate your next purchase.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: decisions.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final decision = decisions[index];
              return Card(
                elevation: 1,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(decision.itemName),
                  subtitle: Text(
                    '${NumberFormat.currency(symbol: '\$').format(decision.price)} • ${DateFormat.yMMMd().format(decision.createdAt)}',
                  ),
                  trailing: StatusBadge(status: decision.result.status),
                  onTap: () => Navigator.of(context)
                      .pushNamed('/detail', arguments: decision),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
