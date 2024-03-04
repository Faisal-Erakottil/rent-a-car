// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailsModelAdapter extends TypeAdapter<UserDetailsModel> {
  @override
  final int typeId = 1;

  @override
  UserDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetailsModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      mobile: fields[2] as String,
      email: fields[3] as String,
      image: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetailsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.mobile)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class vehicleDetailsModelAdapter extends TypeAdapter<vehicleDetailsModel> {
  @override
  final int typeId = 2;

  @override
  vehicleDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return vehicleDetailsModel(
      id: fields[0] as int?,
      vehiclename: fields[1] as String,
      vehiclereg: fields[2] as String,
      fueltype: fields[3] as String,
      seates: fields[4] as String,
      rent: fields[5] as String,
      carimage: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, vehicleDetailsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vehiclename)
      ..writeByte(2)
      ..write(obj.vehiclereg)
      ..writeByte(3)
      ..write(obj.fueltype)
      ..writeByte(4)
      ..write(obj.seates)
      ..writeByte(5)
      ..write(obj.rent)
      ..writeByte(6)
      ..write(obj.carimage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is vehicleDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
