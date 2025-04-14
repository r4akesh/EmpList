
import 'package:employee/data/database_helper.dart';
import 'package:employee/emp_bloc/emp_bloc.dart';
import 'package:employee/emp_bloc/emp_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/employee_list.dart';
void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint("333333");
    return BlocProvider(
      create: (_) => EmployeeBloc(DatabaseHelper.instance)..add(LoadEmployees()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //title: 'Employee Manager',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.lightBlue,
            iconTheme: IconThemeData(color: Colors.white),  // D
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 18),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.blue, // Dark Status bar color

            ),
          ),
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue,
            ),
          ),
        ),
        home: EmployeeListScreen(),
      ),
    );
  }
}

