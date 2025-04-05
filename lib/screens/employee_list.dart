

import 'package:employee/emp_bloc/emp_bloc.dart';
import 'package:employee/emp_bloc/emp_event.dart';
import 'package:employee/emp_bloc/emp_state.dart';
import 'package:employee/screens/add_edit_employee.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/employee_model.dart';

class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees')),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeInitial) {
            return Center(child: CircularProgressIndicator());
          }
         else  if (state is EmployeeLoaded) {
           return ListView(
              children: [
                _buildSectionTitle("Current employees"),
                ...state.currentEmployees.map(
                      (e) => Dismissible(
                    key: ValueKey(e.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      context.read<EmployeeBloc>().add(DeleteEmployee(e.id));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${e.name} deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              context.read<EmployeeBloc>().add(AddEmployee(e));
                            },
                          ),
                        ),
                      );
                    },
                    child: _buildEmployeeTile(e, context),
                  ),
                ),
                _buildSectionTitle("Previous employees"),
                ...state.previousEmployees.map(
                      (e) => Dismissible(
                    key: ValueKey(e.id),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      context.read<EmployeeBloc>().add(DeleteEmployee(e.id));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${e.name} deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              context.read<EmployeeBloc>().add(AddEmployee(e));
                            },
                          ),
                        ),
                      );
                    },
                    child: _buildEmployeeTile(e, context),
                  ),
                ),
              ],
            );

          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton:  Container(
        padding: EdgeInsets.all(5),
        color: Colors.black12,
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text("\t\t\t\t\t\t\tSwipe left to delete",style: TextStyle(fontSize: 15),),

            FloatingActionButton(
              onPressed: () {
                // Add your action here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeeFormScreen()),
                );
              },
              backgroundColor: Colors.blue, // Button color
              child: Icon(Icons.add, size: 30, color: Colors.white), // Plus icon
            ),
          ],
        ),
      ),

    );
  }
  Widget _buildSectionTitle(String title) {
    return Container(

      color: Colors.black12,
      padding: const EdgeInsets.only(left: 20.0,right: 8,top: 8,bottom: 8),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
    );
  }
  Widget _buildEmployeeTile(EmployeeModel employee, BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeFormScreen(
              employeeId: employee.id,
              initialName: employee.name,
              initialRole: employee.role,
              initialStartDate: employee.startDate,
              initialEndDate: employee.endDate,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
          Text(employee.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
        SizedBox(height: 5,),
        Text(
            "${employee.role}",
            style: TextStyle(color: Colors.grey,fontSize: 16),
          ),
            SizedBox(height: 5,),
            Text(
              "From ${employee.startDate}${employee.endDate != null ? ' - ' + employee.endDate! : ''}",
              style: TextStyle(color: Colors.grey,fontSize: 14),
            ),
            SizedBox(height: 5,),
            Divider(
              height: 0.5,
              color: Colors.black12,
            ),
        ],),


      ),
    );
  }

}