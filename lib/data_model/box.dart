import 'package:hive/hive.dart';
import 'package:main_project/data_model/data_model.dart';

class Boxes {
  static Box<UserDetailsModel> getuser() =>
      Hive.box<UserDetailsModel>('details_db');

  static Box<vehicleDetailsModel> getvehicleData() =>
      Hive.box<vehicleDetailsModel>("vehicle_db");

  static Box<CustomerDetailsModel> getcustomerdetails() =>
      Hive.box<CustomerDetailsModel>('customer_db');
}
