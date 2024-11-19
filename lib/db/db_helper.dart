import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';

class DBHelper {
  static const String _databaseName = "expenses.db";
  static const int _databaseVersion = 1;
  static const String table = 'expenses';
  static const String columnId = 'id';
  static const String columnCategory = 'category';
  static const String columnAmount = 'amount';
  static const String columnComments = 'comments';
  static const String columnCreatedAt = 'createdAt';
  static const String columnUpdatedAt = 'updatedAt';

  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _database;

  DBHelper._privateConstructor();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnCategory TEXT NOT NULL,
        $columnAmount REAL NOT NULL,
        $columnComments TEXT,
        $columnCreatedAt TEXT NOT NULL,
        $columnUpdatedAt TEXT
      )
    ''');
  }

  // Insert an Expense into the database
  Future<int> insertExpense(Expense expense) async {
    Database db = await instance.database;
    return await db.insert(table, expense.toMap());
  }

  // Fetch all Expenses from the database
  Future<List<Expense>> fetchAllExpenses() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(table, orderBy: '$columnCreatedAt DESC');

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  // Update an Expense
  Future<int> updateExpense(Expense expense) async {
    Database db = await instance.database;
    return await db.update(
      table,
      expense.toMap(),
      where: '$columnId = ?',
      whereArgs: [expense.id],
    );
  }

  // Delete an Expense by id
  Future<int> deleteExpense(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
