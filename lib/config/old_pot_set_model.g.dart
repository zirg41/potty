// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'old_pot_set_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OldPotSetAdapter extends TypeAdapter<OldPotSet> {
  @override
  final int typeId = 1;

  @override
  OldPotSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OldPotSet(
      id: fields[0] as String,
      income: fields[1] as double,
      name: fields[2] as String,
      pots: (fields[3] as List).cast<OldPot>(),
    )
      ..unallocatedAmount = fields[4] as double
      ..unallocatedPercent = fields[5] as double;
  }

  @override
  void write(BinaryWriter writer, OldPotSet obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.income)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.pots)
      ..writeByte(4)
      ..write(obj.unallocatedAmount)
      ..writeByte(5)
      ..write(obj.unallocatedPercent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OldPotSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
