class EmployeeModel {
  final int id;
  final String name;
  final String role;

  // final DateTime startDate;
  // final DateTime? endDate;
  final String startDate;
  final String? endDate;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap({required bool includeId}) {
    final map;

    if (includeId && id != null) {
      map = {
        'id': id,
        'name': name,
        'role': role,
        'startDate': startDate,
        'endDate': endDate,
      };
    } else {
      map = {
        'name': name,
        'role': role,
        'startDate': startDate,
        'endDate': endDate=="" ? null:endDate,
      };
    }
    return map;
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    var aa = map['endDate'];
    if(aa==null || aa ==""){
      aa = null;
    }
    return EmployeeModel(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      startDate: map['startDate'],
      endDate: aa,
     // endDate: map['endDate'] != null ? map['endDate'] : null,
      //  endDate: map['endDate'],
      // startDate: DateTime.parse(map['startDate']),
      // endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
    );
  }
}
