// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleDetailsModelAdapter extends TypeAdapter<VehicleDetailsModel> {
  @override
  final int typeId = 2;

  @override
  VehicleDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleDetailsModel(
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
  void write(BinaryWriter writer, VehicleDetailsModel obj) {
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
      other is VehicleDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
