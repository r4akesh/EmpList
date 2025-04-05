import 'package:employee/data/employee_model.dart';

abstract class EmployeeEvent {}

class LoadEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final EmployeeModel employee;
  AddEmployee(this.employee);
}

class UpdateEmployee extends EmployeeEvent {
  final EmployeeModel employee;
  UpdateEmployee(this.employee);
}

class DeleteEmployee extends EmployeeEvent {
  final int id;
  DeleteEmployee(this.id);
}

