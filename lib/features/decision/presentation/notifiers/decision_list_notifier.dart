import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/purchase_decision.dart';
import '../../domain/usecases/get_decisions_usecase.dart';

class DecisionListNotifier extends StateNotifier<AsyncValue<List<PurchaseDecision>>> {
  DecisionListNotifier(this._getDecisionsUseCase) : super(const AsyncValue.loading()) {
    load();
  }

  final GetDecisionsUseCase _getDecisionsUseCase;

  Future<void> load() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_getDecisionsUseCase.call);
  }
}
