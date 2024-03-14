// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_types_as_parameter_names, unused_local_variable
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:main_project/data_model/data_model.dart';

ValueNotifier<List<UserDetailsModel>> usernotifer = ValueNotifier([]);
ValueNotifier<List<vehicleDetailsModel>> vehiclenotifer = ValueNotifier([]);
ValueNotifier<List<CustomerDetailsModel>> customerNotifier = ValueNotifier([]);

//=====================================Adding user details
Future<void> addDetail(UserDetailsModel value) async {
  final DetailsDB = await Hive.openBox<UserDetailsModel>('details_db');
  final _id = await DetailsDB.add(value);
  value.id = _id;
  usernotifer.value.add(value);
  usernotifer.notifyListeners();
}

//======================================Getting user Details
Future<void> getDetails() async {
  final DetailsDB = await Hive.openBox<UserDetailsModel>('details_db');
  usernotifer.value.clear();
  usernotifer.value.addAll(DetailsDB.values);
  usernotifer.notifyListeners();
}

//=====================================Add vehicle Details
Future<void> addCar(vehicleDetailsModel value) async {
  final carDB = await Hive.openBox<vehicleDetailsModel>('vehicle_db');
  final id = await carDB.add(value);
  value.id = id;
  vehiclenotifer.value.add(value);
  vehiclenotifer.notifyListeners();
}

//======================================Getting vehicle Details
Future<void> getVehicleDetails() async {
  final vehicleDB = await Hive.openBox<vehicleDetailsModel>('vehicle_db');
  vehiclenotifer.value.clear();
  vehiclenotifer.value.addAll(vehicleDB.values);
  vehiclenotifer.notifyListeners();
}

//=====================================Deleting Data from Box
Future<void> deletVehicle(int id) async {
  final carDB = await Hive.openBox<vehicleDetailsModel>('vehicle_db');
  await carDB.delete(id);
  getVehicleDetails();
}

//======================================update vehicle
Future<void> UpdateVehicle(vehicleDetailsModel updatedVehicle) async {
  final vehicleDB = await Hive.openBox<vehicleDetailsModel>('vehicle_db');
  if (vehicleDB.containsKey(updatedVehicle.key)) {
    await vehicleDB.put(updatedVehicle.key, updatedVehicle);
    getVehicleDetails();
  }
}

//==========================================adding Customer Details
Future<void> addcustomer(CustomerDetailsModel value) async {
  final customerDB = await Hive.openBox<CustomerDetailsModel>("customer_db");
  final id = await customerDB.add(value);
  value.id = id;
  customerNotifier.value.add(value);
  customerNotifier.notifyListeners();
}

//======================================getting Customer Details
Future<void> getCustomerDetails() async {
  final customerDB = await Hive.openBox<CustomerDetailsModel>("customer_db");
  customerNotifier.value.clear();
  customerNotifier.value.addAll(customerDB.values);
  customerNotifier.notifyListeners();
}

//=======================================Delete customer
Future<void> deleteCustomer(int id) async {
  final customerDB = await Hive.openBox<CustomerDetailsModel>('customer_db');
  await customerDB.delete(id);
  getCustomerDetails();
}

//=========================================update customer
Future<void> UpdateCustomer(CustomerDetailsModel updatedCustomer) async {
  final CustomerDB = await Hive.openBox<CustomerDetailsModel>("customer_db");
  if (CustomerDB.containsKey(updatedCustomer.key)) {
    await CustomerDB.put(updatedCustomer.key, updatedCustomer);
    getCustomerDetails();
  }
}

//==================================search vehicle
List<vehicleDetailsModel> searchCars(String query) {
  final vehicleDB = Hive.box<vehicleDetailsModel>("vehicle_db");
  final List<vehicleDetailsModel> allvehicles = vehicleDB.values.toList();

  if (query.isEmpty) {
    return allvehicles;
  }

  final lowerCaseQuery = query.toLowerCase();
  return allvehicles
      .where((vehicle) =>
          vehicle.vehiclename.toLowerCase().contains(lowerCaseQuery))
      .toList();
}

//====================================search Customer
List<CustomerDetailsModel> searchCustomers(String query) {
  final CustomerDB = Hive.box<CustomerDetailsModel>("customer_db");
  final List<CustomerDetailsModel> allCustomers = CustomerDB.values.toList();
  if (query.isEmpty) {
    return allCustomers;
  }
  final lowerCaseQuery = query.toLowerCase();
  return allCustomers.where((Customer) =>
          Customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          Customer.mobilNumber.toLowerCase().contains(query.toLowerCase()))
          .toList();
}
