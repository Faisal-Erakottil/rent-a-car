// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:hive/hive.dart';
part 'data_model.g.dart';

//======================================User Details Data Model
@HiveType(typeId: 1)
class UserDetailsModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String mobile;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String image;

  UserDetailsModel({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.image,
  });
}

//======================================Vehicle Details Data Model
@HiveType(typeId: 2)
class vehicleDetailsModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String vehiclename;
  @HiveField(2)
  final String vehiclereg;
  @HiveField(3)
  final String fueltype;
  @HiveField(4)
  final String seates;
  @HiveField(5)
  final String rent;
  @HiveField(6)
  final String carimage;

  vehicleDetailsModel({
    this.id,
    required this.vehiclename,
    required this.vehiclereg,
    required this.fueltype,
    required this.seates,
    required this.rent,
    required this.carimage,
  });

  set isRented(bool isRented) {}

 
}

//=====================================Customer Details
@HiveType(typeId: 3)
class CustomerDetailsModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String customerName;
  @HiveField(2)
  final String mobilNumber;
  @HiveField(3)
  final String LicenceNumber;
  @HiveField(4)
  final String Email;
  @HiveField(5)
  final String days;
  @HiveField(6)
  final String reading;
  @HiveField(7)
  final String advance;
  @HiveField(8)
  final String CustomerImage;

  CustomerDetailsModel({
    this.id,
    required this.customerName,
    required this.mobilNumber,
    required this.LicenceNumber,
    required this.Email,
    required this.days,
    required this.reading,
    required this.advance,
    required this.CustomerImage,
  });
}
