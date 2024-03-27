// ignore_for_file: camel_case_types

import 'package:hive/hive.dart';
part 'vehicle_db.g.dart';
@HiveType(typeId: 2)
class VehicleDetailsModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String vehiclename;
  @HiveField(2)
  String vehiclereg;
  @HiveField(3)
  String fueltype;
  @HiveField(4)
  String seates;
  @HiveField(5)
  String rent;
  @HiveField(6)
  String carimage;

  VehicleDetailsModel({
    this.id,
    required this.vehiclename,
    required this.vehiclereg,
    required this.fueltype,
    required this.seates,
    required this.rent,
    required this.carimage,
  });

  //get selectedImage => null;

  set selectedImage(String selectedImage) {}

  set fuel(String fuel) {}

  set isRented(bool isRented) {}


 
}
