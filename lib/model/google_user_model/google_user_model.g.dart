// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoogleUserModelAdapter extends TypeAdapter<GoogleUserModel> {
  @override
  GoogleUserModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoogleUserModel(
      email: fields[0] as String,
      displayName: fields[1] as String,
      photoUrl: fields[2] as String,
      id: fields[3] as BigInt,
      appUserKey: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GoogleUserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.appUserKey);
  }

  @override
  // TODO: implement typeId
  int get typeId => 3;
}
