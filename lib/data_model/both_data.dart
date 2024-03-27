import 'package:main_project/data_model/customer_db.dart';
import 'package:main_project/data_model/vehicle_db.dart';

class CombinedData {
  final CustomerDetailsModel customerModel;
  final VehicleDetailsModel vehicleModel;
  CombinedData({
    required this.customerModel,
    required this.vehicleModel,
  });
}