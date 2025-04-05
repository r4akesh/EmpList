import 'package:employee/data/employee_model.dart';

abstract class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {

  final List<EmployeeModel> currentEmployees;
  final List<EmployeeModel> previousEmployees;
  EmployeeLoaded(this.currentEmployees, this.previousEmployees);
}

