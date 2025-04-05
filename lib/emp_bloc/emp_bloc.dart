import 'package:employee/data/database_helper.dart';
import 'package:employee/emp_bloc/emp_event.dart';
import 'package:employee/emp_bloc/emp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  // EmployeeBloc() : super(EmployeeInitial()) {
  //   on<LoadEmployees>((event, emit) async {
  //     final employees = await DatabaseHelper.instance.fetchEmployees();
  //     emit(EmployeeLoaded(employees,employees));
  //   });
  //
  //   on<AddEmployee>((event, emit) async {
  //     await DatabaseHelper.instance.insertEmployee(event.employee);
  //     final employees = await DatabaseHelper.instance.fetchEmployees();
  //     emit(EmployeeLoaded(employees));
  //   });
  //
  //   on<UpdateEmployee>((event, emit) async {
  //     await DatabaseHelper.instance.updateEmployee(event.employee);
  //     final employees = await DatabaseHelper.instance.fetchEmployees();
  //     emit(EmployeeLoaded(employees));
  //   });
  //
  //   on<DeleteEmployee>((event, emit) async {
  //     await DatabaseHelper.instance.deleteEmployee(event.id);
  //     final employees = await DatabaseHelper.instance.fetchEmployees();
  //     emit(EmployeeLoaded(employees));
  //   });
  // }

  final DatabaseHelper dbHelper;

  EmployeeBloc(this.dbHelper) : super(EmployeeInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
  }

  Future<void> _onLoadEmployees(LoadEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeInitial());
    final currentEmployees = await dbHelper.fetchEmployees(isCurrent: true);
    final previousEmployees = await dbHelper.fetchEmployees(isCurrent: false);
    emit(EmployeeLoaded(currentEmployees, previousEmployees));
  }

  Future<void> _onAddEmployee(AddEmployee event, Emitter<EmployeeState> emit) async {
    await dbHelper.insertEmployee(event.employee);
    add(LoadEmployees());
  }

  Future<void> _onDeleteEmployee(DeleteEmployee event, Emitter<EmployeeState> emit) async {
    final db = await dbHelper.database;
    await db.delete('employees', where: 'id = ?', whereArgs: [event.id]);
    add(LoadEmployees());
  }

  Future<void> _onUpdateEmployee(UpdateEmployee event, Emitter<EmployeeState> emit) async {
    await dbHelper.updateEmployee(event.employee); // assumes this method exists
    add(LoadEmployees()); // reload the employee list
  }




}
