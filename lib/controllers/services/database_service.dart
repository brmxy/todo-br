import 'package:path/path.dart';
import 'package:todo/controllers/services/index.dart';
import 'package:todo/utils/sql/index.dart';

class DatabaseService {
  DatabaseService._initService();

  static final DatabaseService instance = DatabaseService._initService();
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB('todo_br.db');

    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(kTableProject);
    await db.execute(kTableTask);
  }

  Future<void> closeDB() async {
    final db = await instance.db;

    db.close();
  }
}
