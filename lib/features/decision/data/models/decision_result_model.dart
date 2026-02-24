import 'package:hive/hive.dart';

import '../../domain/entities/decision_enums.dart';
import '../../domain/entities/decision_result.dart';


@HiveType(typeId: 1)
class DecisionResultModel {
  const DecisionResultModel({
    required this.status,
    required this.message,
    required this.impactPercentage,
  });

  @HiveField(0)
  final DecisionStatus status;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final double impactPercentage;

  DecisionResult toEntity() {
    return DecisionResult(
      status: status,
      message: message,
      impactPercentage: impactPercentage,
    );
  }

  factory DecisionResultModel.fromEntity(DecisionResult result) {
    return DecisionResultModel(
      status: result.status,
      message: result.message,
      impactPercentage: result.impactPercentage,
    );
  }
}

class DecisionResultModelAdapter extends TypeAdapter<DecisionResultModel> {
  @override
  final int typeId = 1;

  @override
  DecisionResultModel read(BinaryReader reader) {
    return DecisionResultModel(
      status: DecisionStatus.values[reader.readInt()],
      message: reader.readString(),
      impactPercentage: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, DecisionResultModel obj) {
    writer
      ..writeInt(obj.status.index)
      ..writeString(obj.message)
      ..writeDouble(obj.impactPercentage);
  }
}
