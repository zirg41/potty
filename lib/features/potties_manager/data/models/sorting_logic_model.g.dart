// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sorting_logic_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SortingLogicModelAdapter extends TypeAdapter<SortingLogicModel> {
  @override
  final int typeId = 2;

  @override
  SortingLogicModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SortingLogicModel.lowToHigh;
      case 1:
        return SortingLogicModel.highToLow;
      case 2:
        return SortingLogicModel.manual;
      default:
        return SortingLogicModel.lowToHigh;
    }
  }

  @override
  void write(BinaryWriter writer, SortingLogicModel obj) {
    switch (obj) {
      case SortingLogicModel.lowToHigh:
        writer.writeByte(0);
        break;
      case SortingLogicModel.highToLow:
        writer.writeByte(1);
        break;
      case SortingLogicModel.manual:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortingLogicModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
