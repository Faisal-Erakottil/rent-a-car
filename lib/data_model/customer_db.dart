// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';

part 'customer_db.g.dart';

@HiveType(typeId: 3)
class CustomerDetailsModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  late final String customerName;

  @HiveField(2)
  late final String mobilNumber;

  @HiveField(3)
  late final String licenceNumber;

  @HiveField(4)
  late final String email;

  @HiveField(5)
  late final String pickUpDate;

  @HiveField(6)
  late final String dropOffDate;

  @HiveField(7)
  late final String reading;

  @HiveField(8)
  late final String advance;

  @HiveField(9)
  late final String CustomerImage;

  CustomerDetailsModel({
    this.id,
    required this.customerName,
    required this.mobilNumber,
    required this.licenceNumber,
    required this.email,
    required this.pickUpDate,
    required this.dropOffDate,
    required this.reading,
    required this.advance,
    required this.CustomerImage,
  });
}
