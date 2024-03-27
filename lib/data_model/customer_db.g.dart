// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerDetailsModelAdapter extends TypeAdapter<CustomerDetailsModel> {
  @override
  final int typeId = 3;

  @override
  CustomerDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerDetailsModel(
      id: fields[0] as int?,
      customerName: fields[1] as String,
      mobilNumber: fields[2] as String,
      licenceNumber: fields[3] as String,
      email: fields[4] as String,
      pickUpDate: fields[5] as String,
      dropOffDate: fields[6] as String,
      reading: fields[7] as String,
      advance: fields[8] as String,
      CustomerImage: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerDetailsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.mobilNumber)
      ..writeByte(3)
      ..write(obj.licenceNumber)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.pickUpDate)
      ..writeByte(6)
      ..write(obj.dropOffDate)
      ..writeByte(7)
      ..write(obj.reading)
      ..writeByte(8)
      ..write(obj.advance)
      ..writeByte(9)
      ..write(obj.CustomerImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
