import 'package:enviocrsl/app/data/models/ScannedData.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database _database;

  Future<Database> get dbInstance async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'enviocrsl_.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE scannedData(id STRING PRIMARY KEY, no INTEGER, nama TEXT, ekspedisi TEXT,isSubmitted INTEGER)',
        );
      },
    );
  }

  // fetch Data to List
  Future<List<ScannedData>> getScannedData() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db.query('scannedData');

    return List.generate(
      maps.length,
      (i) {
        return ScannedData(
          id: maps[i]['id'],
          no: maps[i]['no'].toString(),
          nama: maps[i]['nama'],
          ekspedisi: maps[i]['ekspedisi'],
          isSubmitted: (maps[i]['isSubmitted']),
        );
      },
    );
  }

  // Save Data
  Future<void> saveScannedData(ScannedData data) async {
    final db = await dbInstance;
    await db.insert('scannedData', data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Update to submitted
  Future<void> updateDataToSubmitted(List<ScannedData> unSubmittedData) async {
    final db = await dbInstance;
    unSubmittedData.forEach(
      (element) async {
        await db.update('scannedData', element.toMap(),
            where: 'id = ?', whereArgs: [element.id]);
      },
    );
  }

  // Delete data by No
  Future<void> deleteDataByNo(String id) async {
    final db = await dbInstance;
    db.delete('scannedData', where: 'id = ?', whereArgs: [id]);
    print("data $id deleted");
  }

  // Delete All Data
  Future<void> deleteAllData() async {
    final db = await dbInstance;
    db.delete('scannedData');
  }

  // Get Not Submitted Data Count
  Future<int> getNoSubmittedDataCount() async {
    final db = await dbInstance;
    var count = 0;
    List<Map> result = await db
        .rawQuery('SELECT COUNT(*) FROM scannedData WHERE isSubmitted=?', [0]);

    result.forEach((element) {
      print(element.values.first);
      count = element.values.first;
    });

    return count;
  }
}
