// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_tiles.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListOfTilesViewModelAdapter extends TypeAdapter<ListOfTilesViewModel> {
  @override
  final int typeId = 0;

  @override
  ListOfTilesViewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListOfTilesViewModel()
      ..tiles = (fields[0] as List)?.cast<ListOfTilesModel>();
  }

  @override
  void write(BinaryWriter writer, ListOfTilesViewModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tiles)
      ..writeByte(1)
      ..write(obj.singleton);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListOfTilesViewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
