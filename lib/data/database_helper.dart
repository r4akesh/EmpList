import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data/employee_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('employees.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE employees (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            role TEXT,
            startDate TEXT,
            endDate TEXT
          )
        ''');
      },
    );
  }

  Future<List<EmployeeModel>> fetchEmployees({bool isCurrent = true}) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'employees',
      where: isCurrent ? 'endDate IS NULL OR endDate = ""' : 'endDate IS NOT NULL OR endDate != ""',
    );
    return result.map((e) => EmployeeModel.fromMap(e)).toList();
  }



  Future<int> insertEmployee(EmployeeModel employee) async {
    final db = await instance.database;
    return await db.insert('employees', employee.toMap(includeId: false));
  }

  Future<int> updateEmployee(EmployeeModel employee) async {
    final db = await instance.database;
    return await db.update(
      'employees',
      employee.toMap(includeId: true),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }
  Future<int> deleteEmployee(int id) async {
    final db = await instance.database;
    return await db.delete('employees', where: 'id = ?', whereArgs: [id]);
  }
}
