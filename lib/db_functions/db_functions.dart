// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:main_project/data_model/data_model.dart';

ValueNotifier<List<UserDetailsModel>> usernotifer = ValueNotifier([]);
ValueNotifier<List<vehicleDetailsModel>> vehiclenotifer = ValueNotifier([]);
ValueNotifier<List<CustomerDetailsModel>> customerListNotifier =
    ValueNotifier([]);
//=====================================Adding Data to Box
Future<void> addDetail(UserDetailsModel value) async {
  final DetailsDB = await Hive.openBox<UserDetailsModel>('details_db');
  final _id = await DetailsDB.add(value);
  value.id = _id;
  usernotifer.value.add(value);
  usernotifer.notifyListeners();
}

//======================================Getting from box
Future<void> getDetails() async {
  final DetailsDB = await Hive.openBox<UserDetailsModel>('details_db');
  usernotifer.value.clear();
  usernotifer.value.addAll(DetailsDB.values);
  usernotifer.notifyListeners();
}

//=====================================Adding Data to Box
Future<void> addCar(vehicleDetailsModel value) async {
  final carDB = await Hive.openBox<vehicleDetailsModel>('vehicle_db');
  final id = await carDB.add(value);
  value.id = id;
  vehiclenotifer.value.add(value);
  vehiclenotifer.notifyListeners();
}

//======================================Getting vehicle Details from box
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
//=========================================update customer
Future<void> UpdateCustomer(CustomerDetailsModel updatedCustomer) async {
  final CustomerDB = await Hive.openBox<CustomerDetailsModel>("ustomer_db");
  if (CustomerDB.containsKey(updatedCustomer.key)) {
    await CustomerDB.put(updatedCustomer.key, updatedCustomer);
    getAllCustomers();
  }
}
//=====================================adding Customer
Future<void> addcustomer(CustomerDetailsModel value) async {
  final customerDB = await Hive.openBox<CustomerDetailsModel>("customer_db");
  final id = await customerDB.add(value);
  value.id = id;
  customerListNotifier.value.add(value);
  customerListNotifier.notifyListeners();
}

//======================================Customer Details from Box
Future<void> getAllCustomers() async {
  final customerDB = await Hive.openBox<CustomerDetailsModel>("customer_db");
  customerListNotifier.value.clear();
  customerListNotifier.value.addAll(customerDB.values);
  customerListNotifier.notifyListeners();
}


