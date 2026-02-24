import 'package:flutter/material.dart';

import '../../domain/entities/decision_enums.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final DecisionStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      DecisionStatus.safe => (Colors.green, 'SAFE'),
      DecisionStatus.consider => (Colors.orange, 'CONSIDER'),
      DecisionStatus.risky => (Colors.red, 'RISKY'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 11),
      ),
    );
  }
}
