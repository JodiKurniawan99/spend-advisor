import 'package:hive/hive.dart';

import '../../../../core/constants/hive_boxes.dart';
import '../models/decision_model.dart';

class DecisionLocalDataSource {
  const DecisionLocalDataSource(this._box);

  final Box<DecisionModel> _box;

  static Future<DecisionLocalDataSource> create() async {
    final box = await Hive.openBox<DecisionModel>(HiveBoxes.decisionsBox);
    return DecisionLocalDataSource(box);
  }

  Future<void> addDecision(DecisionModel model) async {
    await _box.put(model.id, model);
  }

  List<DecisionModel> getDecisions() {
    final items = _box.values.toList();
    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }
}
