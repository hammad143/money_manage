// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_tiles_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListTilesModelNewAdapter extends TypeAdapter<ListOfTilesModel> {
  @override
  ListOfTilesModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListOfTilesModel(
      title: fields[0] as String,
      amount: fields[1] as String,
      dateInString: fields[2] as String,
      option: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ListOfTilesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.dateInString)
      ..writeByte(3)
      ..write(obj.option);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
