import 'package:hive/hive.dart';

import '../../domain/entities/decision_enums.dart';
import '../../domain/entities/purchase_decision.dart';
import 'decision_result_model.dart';

@HiveType(typeId: 0)
class DecisionModel {
  const DecisionModel({
    required this.id,
    required this.itemName,
    required this.price,
    required this.category,
    required this.urgencyLevel,
    required this.type,
    required this.paymentType,
    required this.monthlyIncome,
    required this.currentSavings,
    required this.monthlyExpense,
    required this.result,
    required this.createdAt,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String itemName;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final DecisionCategory category;

  @HiveField(4)
  final int urgencyLevel;

  @HiveField(5)
  final PurchaseType type;

  @HiveField(6)
  final PaymentType paymentType;

  @HiveField(7)
  final double monthlyIncome;

  @HiveField(8)
  final double currentSavings;

  @HiveField(9)
  final double monthlyExpense;

  @HiveField(10)
  final DecisionResultModel result;

  @HiveField(11)
  final DateTime createdAt;

  PurchaseDecision toEntity() {
    return PurchaseDecision(
      id: id,
      itemName: itemName,
      price: price,
      category: category,
      urgencyLevel: urgencyLevel,
      type: type,
      paymentType: paymentType,
      monthlyIncome: monthlyIncome,
      currentSavings: currentSavings,
      monthlyExpense: monthlyExpense,
      result: result.toEntity(),
      createdAt: createdAt,
    );
  }

  factory DecisionModel.fromEntity(PurchaseDecision entity) {
    return DecisionModel(
      id: entity.id,
      itemName: entity.itemName,
      price: entity.price,
      category: entity.category,
      urgencyLevel: entity.urgencyLevel,
      type: entity.type,
      paymentType: entity.paymentType,
      monthlyIncome: entity.monthlyIncome,
      currentSavings: entity.currentSavings,
      monthlyExpense: entity.monthlyExpense,
      result: DecisionResultModel.fromEntity(entity.result),
      createdAt: entity.createdAt,
    );
  }
}

class DecisionModelAdapter extends TypeAdapter<DecisionModel> {
  @override
  final int typeId = 0;

  @override
  DecisionModel read(BinaryReader reader) {
    return DecisionModel(
      id: reader.readString(),
      itemName: reader.readString(),
      price: reader.readDouble(),
      category: DecisionCategory.values[reader.readInt()],
      urgencyLevel: reader.readInt(),
      type: PurchaseType.values[reader.readInt()],
      paymentType: PaymentType.values[reader.readInt()],
      monthlyIncome: reader.readDouble(),
      currentSavings: reader.readDouble(),
      monthlyExpense: reader.readDouble(),
      result: reader.read() as DecisionResultModel,
      createdAt: reader.readDateTime(),
    );
  }

  @override
  void write(BinaryWriter writer, DecisionModel obj) {
    writer
      ..writeString(obj.id)
      ..writeString(obj.itemName)
      ..writeDouble(obj.price)
      ..writeInt(obj.category.index)
      ..writeInt(obj.urgencyLevel)
      ..writeInt(obj.type.index)
      ..writeInt(obj.paymentType.index)
      ..writeDouble(obj.monthlyIncome)
      ..writeDouble(obj.currentSavings)
      ..writeDouble(obj.monthlyExpense)
      ..write(obj.result)
      ..writeDateTime(obj.createdAt);
  }
}

class DecisionCategoryAdapter extends TypeAdapter<DecisionCategory> {
  @override
  final int typeId = 2;

  @override
  DecisionCategory read(BinaryReader reader) =>
      DecisionCategory.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, DecisionCategory obj) =>
      writer.writeInt(obj.index);
}

class PurchaseTypeAdapter extends TypeAdapter<PurchaseType> {
  @override
  final int typeId = 3;

  @override
  PurchaseType read(BinaryReader reader) => PurchaseType.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, PurchaseType obj) => writer.writeInt(obj.index);
}

class PaymentTypeAdapter extends TypeAdapter<PaymentType> {
  @override
  final int typeId = 4;

  @override
  PaymentType read(BinaryReader reader) => PaymentType.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, PaymentType obj) => writer.writeInt(obj.index);
}

class DecisionStatusAdapter extends TypeAdapter<DecisionStatus> {
  @override
  final int typeId = 5;

  @override
  DecisionStatus read(BinaryReader reader) =>
      DecisionStatus.values[reader.readInt()];

  @override
  void write(BinaryWriter writer, DecisionStatus obj) => writer.writeInt(obj.index);
}
