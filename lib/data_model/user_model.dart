// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:hive/hive.dart';
part 'user_model.g.dart';

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