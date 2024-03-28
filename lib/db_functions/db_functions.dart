// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_types_as_parameter_names, unused_local_variable
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/customer_db.dart';
import 'package:main_project/data_model/user_model.dart';
import 'package:main_project/data_model/vehicle_db.dart';

ValueNotifier<List<UserDetailsModel>> usernotifer = ValueNotifier([]);
ValueNotifier<List<VehicleDetailsModel>> vehiclenotifer = ValueNotifier([]);
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
Future<void> addCar(VehicleDetailsModel value) async {
  final carDB = await Hive.openBox<VehicleDetailsModel>('vehicle_db');
  final id = await carDB.add(value);
  value.id = id;
  vehiclenotifer.value.add(value);
  vehiclenotifer.notifyListeners();
}

//======================================Getting vehicle Details
Future<void> getVehicleDetails() async {
  final vehicleDB = await Hive.openBox<VehicleDetailsModel>('vehicle_db');
  vehiclenotifer.value.clear();
  vehiclenotifer.value.addAll(vehicleDB.values);
  vehiclenotifer.notifyListeners();
}

//===================================== Deleting Data from vehicle Box
Future<void> deletVehicle(VehicleDetailsModel vehicleModel) async {
  final carDB = await Hive.openBox<VehicleDetailsModel>('vehicle_db');
  await vehicleModel.delete();
  getVehicleDetails();
}



//=======================================Remove vehicle
List<VehicleDetailsModel> removedVehicleList = [];
void removeCarFromScreen(VehicleDetailsModel vehicle) {
  removedVehicleList.add(vehicle);
  vehiclenotifer.value.remove(vehicle);
  Boxes.getvehicleData().delete(vehicle.key);
  vehiclenotifer.notifyListeners();
}

List<VehicleDetailsModel> getRemovedVehicle() {
  return removedVehicleList;
}

void clearRemovedVehicle() {
  removedVehicleList.clear();
}

//=======================================remove customers
List<CustomerDetailsModel> removedCustomersList = [];
void removeCustomerFromScreen(CustomerDetailsModel customer) {
  removedCustomersList.add(customer);
  customerNotifier.value.remove(customer);
  Boxes.getcustomerdetail().delete(customer.key);
}

List<CustomerDetailsModel> getRemovedCustomers() {
  return removedCustomersList;
}

void clearRemovedCustomers() {
  removedCustomersList.clear();
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
//======================================Deleting data from Customer Box
Future<void> deleteCustomer(CustomerDetailsModel customerModel) async {
  final customerDB = await Hive.openBox<CustomerDetailsModel>('customer_db');
  await customerModel.delete();
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
List<VehicleDetailsModel> searchCars(String query) {
  final vehicleDB = Hive.box<VehicleDetailsModel>("vehicle_db");
  final List<VehicleDetailsModel> allvehicles = vehicleDB.values.toList();

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
  return allCustomers
      .where((Customer) =>
          Customer.customerName.toLowerCase().contains(query.toLowerCase()) ||
          Customer.mobilNumber.toLowerCase().contains(query.toLowerCase()))
      .toList();
}
