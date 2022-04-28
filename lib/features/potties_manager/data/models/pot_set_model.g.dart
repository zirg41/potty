// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pot_set_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PotSetHiveModelAdapter extends TypeAdapter<PotSetHiveModel> {
  @override
  final int typeId = 1;

  @override
  PotSetHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PotSetHiveModel(
      id: fields[0] as String,
      income: fields[2] as double,
      name: fields[1] as String,
      createdDate: fields[3] as DateTime,
      pots: (fields[4] as List).cast<PotHiveModel>(),
      unallocatedBalance: fields[5] as double?,
      unallocatedPercent: fields[6] as double?,
      sortingLogic: fields[7] as SortingLogicModel,
    );
  }

  @override
  void write(BinaryWriter writer, PotSetHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.income)
      ..writeByte(3)
      ..write(obj.createdDate)
      ..writeByte(4)
      ..write(obj.pots)
      ..writeByte(5)
      ..write(obj.unallocatedBalance)
      ..writeByte(6)
      ..write(obj.unallocatedPercent)
      ..writeByte(7)
      ..write(obj.sortingLogic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PotSetHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
