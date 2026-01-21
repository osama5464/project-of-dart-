import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task_model.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static Database? _db;
  static const int _version = 2;
  static const String _tableName = 'tasks';
  Future<Database> get mydb async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    try {
      String _path = join(await getDatabasesPath(), 'tasks.db');
      return await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE $_tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              priority TEXT,
              dueDate TEXT,
              isCompleted INTEGER,
              category TEXT,
              createdAt TEXT
            )
            ''');
          await _createCategoriesTable(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await _createCategoriesTable(db);
          }
        },
      );
    } catch (e) {
      print("DB Init Error: $e");
      rethrow;
    }
  }

  // ===== CRUD Methods =====

  Future<int> insert(Task task) async {
    final db = await mydb;
    return await db.insert(_tableName, task.toJson());
  }

  Future<List<Map<String, dynamic>>> query() async {
    final db = await mydb;
    return await db.query(_tableName);
  }

  Future<int> delete(Task task) async {
    final db = await mydb;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> updateCompleted(int id) async {
    final db = await mydb;
    return await db.rawUpdate(
      '''
      UPDATE $_tableName
      SET isCompleted = ?
      WHERE id = ?
      ''',
      [1, id],
    );
  }

  Future<int> updateTask(Task task) async {
    final db = await mydb;
    return await db.update(
      _tableName,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> _createCategoriesTable(Database db) async {
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
      ''');
    // Insert default categories
    var batch = db.batch();
    List<String> defaults = ["Work", "Personal", "Shopping", "Health"];
    for (var cat in defaults) {
      batch.insert('categories', {'name': cat});
    }
    await batch.commit();
  }

  Future<int> insertCategory(String name) async {
    final db = await mydb;
    return await db.insert('categories', {'name': name});
  }

  Future<List<Map<String, dynamic>>> queryCategories() async {
    final db = await mydb;
    return await db.query('categories');
  }
}
