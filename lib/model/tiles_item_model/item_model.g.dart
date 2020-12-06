// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAddingModelAdapter extends TypeAdapter<ItemsAddingModel> {
  @override
  ItemsAddingModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemsAddingModel()
      .._title = fields[0] as String
      .._amount = fields[1] as String
      .._date = fields[2] as String
      .._option = fields[3] as String
      .._currency = fields[4] as String
      .._lat = fields[5] as double
      .._long = fields[6] as double;
  }

  @override
  void write(BinaryWriter writer, ItemsAddingModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj._title)
      ..writeByte(1)
      ..write(obj._amount)
      ..writeByte(2)
      ..write(obj._date)
      ..writeByte(3)
      ..write(obj._option)
      ..writeByte(4)
      ..write(obj._currency)
      ..writeByte(5)
      ..write(obj._lat)
      ..writeByte(6)
      ..write(obj._long);
  }

  @override
  // TODO: implement typeId
  int get typeId => 4;
}
