import 'package:hive/hive.dart';
import 'package:main_project/data_model/customer_db.dart';
import 'package:main_project/data_model/user_model.dart';
import 'package:main_project/data_model/vehicle_db.dart';

class Boxes {
  static Box<UserDetailsModel> getuser() =>
      Hive.box<UserDetailsModel>('details_db');

  static Box<VehicleDetailsModel> getvehicleData() =>
      Hive.box<VehicleDetailsModel>("vehicle_db");

  static Box<CustomerDetailsModel> getcustomerdetail() =>
      Hive.box<CustomerDetailsModel>('customer_db');

}
