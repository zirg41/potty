// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'old_pot_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OldPotAdapter extends TypeAdapter<OldPot> {
  @override
  final int typeId = 0;

  @override
  OldPot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OldPot(
      id: fields[0] as String,
      name: fields[1] as String,
      percent: fields[2] as double,
      amount: fields[3] as double,
      isAmountFixed: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OldPot obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.percent)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.isAmountFixed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OldPotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
