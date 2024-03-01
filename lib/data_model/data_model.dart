// ignore_for_file: camel_case_types

import 'package:hive/hive.dart';
part 'data_model.g.dart';

//======================================User Details Data Model
@HiveType(typeId: 1)
class UserDetailsModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final String mobile;
  @HiveField(3)
  late final String email;
  @HiveField(4)
  late final String image;

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
  late final String vehiclename;
  @HiveField(2)
  late final String vehiclereg;
  @HiveField(3)
  late final String fueltype;
  @HiveField(4)
  late final String seates;
  @HiveField(5)
  late final String rent;
  @HiveField(6)
  late final String image;

  vehicleDetailsModel({
    this.id,
    required this.vehiclename,
    required this.vehiclereg,
    required this.fueltype,
    required this.seates,
    required this.rent,
    required this.image,
  });
}


