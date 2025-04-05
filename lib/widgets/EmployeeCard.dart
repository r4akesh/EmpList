
import 'package:employee/data/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeModel employee;
  EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(employee.name),
     // subtitle: Text(employee.position),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/edit', arguments: employee);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Dispatch Delete Event
            },
          ),
        ],
      ),
    );
  }
}