import 'dart:math';


import 'package:employee/data/employee_model.dart';
import 'package:employee/emp_bloc/emp_bloc.dart';
import 'package:employee/emp_bloc/emp_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class EmployeeFormScreen extends StatefulWidget {
  final int? employeeId;
  final String? initialName;
  final String? initialRole;
  final String? initialStartDate;
  final String? initialEndDate;
  // final DateTime? initialStartDate;
  // final DateTime? initialEndDate;

  const EmployeeFormScreen({
    Key? key,
    this.employeeId,
    this.initialName,
    this.initialRole,
    this.initialStartDate,
    this.initialEndDate,
  }) : super(key: key);

  @override
  _EmployeeFormScreenState createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _roleController;
  late TextEditingController _initialStartDate;
  late TextEditingController _initialEndDate;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _roleController = TextEditingController(text: widget.initialRole ?? '');
    _initialStartDate = TextEditingController(text:widget.initialStartDate ?? '');
    _initialEndDate = TextEditingController(text: widget.initialEndDate ?? '');
   // _startDate = widget.initialStartDate ?? DateTime.now();
    //_endDate = widget.initialEndDate;
  }



  Future<void> _selectDate(BuildContext context,bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (isStart) {
       // _startDate = pickedDate;

        DateTime parsedDate = DateTime.parse(pickedDate.toLocal().toString().split(' ')[0]);
        _initialStartDate.text = DateFormat('d MMM yyyy').format(parsedDate);

      } else {
       // _endDate = pickedDate;
        _initialEndDate.text = DateFormat('d MMM yyyy').format(DateTime.parse(pickedDate.toLocal().toString().split(' ')[0]));
      }

    }
  }



  void _saveEmployee() {
    if (_formKey.currentState!.validate()) {
      final employee = EmployeeModel(
        id: widget.employeeId ?? 0,
        name: _nameController.text,
        role: _roleController.text,
        // startDate: DateTime.parse(_initialStartDate.text),
        // endDate: _initialEndDate.text.isNotEmpty ? DateTime.parse(_initialEndDate.text) : null,
        startDate: _initialStartDate.text,
        endDate: _initialEndDate.text,
      );

      if (widget.employeeId == null) {
        context.read<EmployeeBloc>().add(AddEmployee(employee));
      } else {
        context.read<EmployeeBloc>().add(UpdateEmployee(employee));
      }
       Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.employeeId == null ? 'Add Employee Details' : 'Edit Employee Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
              decoration: InputDecoration(
                //labelText: 'Employee Name',
                hintText: 'Employee Name',
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset("assets/image/ic_emp.png",width: 10,height: 10,),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
              ),

              SizedBox(height: 20,),
              TextFormField(
                onTap: (){
                  // showMyBottomSheet(context);
                  _showRoleSelection(context);
                },
                controller: _roleController,
                  readOnly: true,
                  decoration: InputDecoration(
                    // /labelText: 'Role',
                    hintText: 'Select Role',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset("assets/image/ic_arrow.png",width: 10,height: 10,),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset("assets/image/ic_role.png",width: 10,height: 10,),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                validator: (value) => value!.isEmpty ? 'Enter a role' : null,
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onTap: (){
                        _selectDate(context, true);
                      },
                      controller: _initialStartDate,
                      readOnly: true,
                      decoration: InputDecoration(
                        //labelText: 'No Date',
                        hintText: 'No Date',

                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/image/ic_cale.png",width: 10,height: 10,),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter start date' : null,
                    ),
                  ),




                    Image.asset("assets/image/ic_arrow_line.png",width: 25,height: 25,),

                  Expanded(
                    child: TextFormField(
                      onTap: (){
                        _selectDate(context, false);
                      },
                      controller: _initialEndDate,
                      readOnly: true,
                      decoration: InputDecoration(
                        //labelText: 'No Date',
                        hintText: 'No Date',

                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset("assets/image/ic_cale.png",width: 10,height: 10,),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      //validator: (value) => value!.isEmpty ? 'Enter end date' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Spacer(),

              Divider(
                height: 0.5,
                color: Colors.black12,
              ),
              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              Container(
              decoration: BoxDecoration(
              color: Color(0xFFEAF5FF), // Light blue background
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          "Cancel",
          style: TextStyle(
            color: Color(0xFF007AFF), // Blue text color
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
                  //TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: (){
                    if(isDataValid()){
                      _saveEmployee();
                    }

                  }, child: const Text('Save')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


    void _showRoleSelection(BuildContext context) async {

      String? selectedRole = await showModalBottomSheet<String>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Wrap(
            children: [
              ListTile(
                title: Center(child: Text("Product Designer")),
                onTap: () => Navigator.pop(context, "Product Designer"),
              ),
              ListTile(
                title: Center(child: Text("Flutter Developer")),
                onTap: () => Navigator.pop(context, "Flutter Developer"),
              ),
              ListTile(
                title: Center(child: Text("QA Tester")),
                onTap: () => Navigator.pop(context, "QA Tester"),
              ),
              ListTile(
                title: Center(child: Text("Product Owner")),
                onTap: () => Navigator.pop(context, "Product Owner"),
              ),
            ],
          );
        },
      );

      if (selectedRole != null) {
        _roleController.text = selectedRole; // Update value without setState
      }
    }

  bool isDataValid() {
    if(_initialEndDate.text.isEmpty){
      return true;
    }
    final dateFormat = DateFormat('d MMM yyyy');

    DateTime startDate = dateFormat.parse(_initialStartDate.text);
    DateTime endDate = dateFormat.parse(_initialEndDate.text);


    if (startDate.isBefore(endDate)) {
      print('Start date is before end date');
      return true;
    } else if (startDate.isAfter(endDate)) {
      print('Start date is after end date');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('End date should be after stat date'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    } else {
      print('Both dates are same');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('End date should be after stat date'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }


  }


}