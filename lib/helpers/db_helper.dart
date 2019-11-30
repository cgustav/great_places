import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    //the path where you may
    //store things in your
    //local database.
    final dbPath = await sql.getDatabasesPath();
    //alows us to open the database,
    //also open the specified database from
    //path in the case it already exists.
    //Otherwise it will create a new one.
    //
    //It need to have .db extension
    return await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (sql.Database db, int version) {
      //REAL is a number with decimal places
      return db.execute('CREATE TABLE user_places'
          '(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert({String table, Map<String, Object> data}) async {
    final sqlDB = await DBHelper.database();

    /// sql.ConflictAlgorithm helps us to
    /// handle situations like when we are trying
    /// to save an object with an already existing
    /// id, in this case we choose the
    /// ConflictAlgorithm.replace option to write
    /// (override) data anyway.
    await sqlDB.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetch({String table}) async {
    final sqlDB = await DBHelper.database();

    return await sqlDB.query(table);
  }
}
