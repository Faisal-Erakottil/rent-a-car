import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/screens/spalsh_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //========================================Hive Adapter One
  if (!Hive.isAdapterRegistered(UserDetailsModelAdapter().typeId)) {
    Hive.registerAdapter(UserDetailsModelAdapter());
  }
  await Hive.openBox<UserDetailsModel>('details_db');
  //========================================Hive Adapter two
  if (!Hive.isAdapterRegistered(vehicleDetailsModelAdapter().typeId)) {
    Hive.registerAdapter(vehicleDetailsModelAdapter());
  }
  await Hive.openBox<vehicleDetailsModel>("vehicle_db");
  //========================================

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rent a Car',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
