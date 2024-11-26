import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotificationDatabase {
  late Database _database;

  Future<Database> openMyDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notifications.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return db.execute(
          'CREATE TABLE notifications(id TEXT, title TEXT, description TEXT, date TEXT)',
        );
      },
    );
    return database;
  }

  Future<void> insertNotification(
      String id, String title, String description, String date) async {
    final db = await openMyDatabase();
    await db.insert(
      'notifications',
      {'id': id, 'title': title, 'description': description, 'date': date},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getNotifications() async {
    final db = await openMyDatabase();
    return await db.query('notifications');
  }

  Future<bool> isNotificationIDPresent(String id) async {
    final db = await openMyDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      'notifications',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<void> deleteNotification(String id) async {
    final db = await openMyDatabase();
    await db.delete(
      'notifications',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
