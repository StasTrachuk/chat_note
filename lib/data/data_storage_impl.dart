import 'package:home_work/core/data_storage.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class ChatFields {
  static const String chatsTableName = 'chats';
  static const String id = 'chatId';
  static const String title = 'title';
  static const String icon = 'icon';
}

class MessageFields {
  static const String messagesTableName = 'messages';
  static const String id = '_messageId';
  static const String chatId = 'chatId';
  static const String text = 'text';
  static const String image = 'image';
  static const String time = 'time';
  static const String date = 'date';
  static const String messageCategory = 'messageCategory';
}

class DataStorageImpl implements DataStorage {
  static const String _name = 'notes.db';
  static Database? _database;

  static DataStorageImpl instance = DataStorageImpl._init();

  DataStorageImpl._init();

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_name);

    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${ChatFields.chatsTableName} 
      (
       ${ChatFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
       ${ChatFields.title} TEXT NOT NULL,
       ${ChatFields.icon} TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE ${MessageFields.messagesTableName} 
      (
       ${MessageFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
       ${MessageFields.text} TEXT,
       ${MessageFields.image} BLOB,
       ${MessageFields.time} TEXT,
       ${MessageFields.date} TEXT,
       ${MessageFields.messageCategory} TEXT,
       ${MessageFields.chatId} INTEGER,
       
       FOREIGN KEY (${MessageFields.chatId}) REFERENCES ${ChatFields.chatsTableName}(${ChatFields.id}) ON DELETE CASCADE
      )
      ''');
  }

  @override
  Future<void> close() async {
    final db = await database;
    db.close();
  }

  @override
  Future<List<Map<String, Object?>>> read({
    required String table,
    String? column,
    List<Object?>? args,
  }) async {
    final db = await database;

    return (column == null)
        ? await db.query(table)
        : await db.query(
            table,
            where: '$column = ?',
            whereArgs: args,
          );
  }

  @override
  Future<void> delete({
    required String table,
    required String column,
    required List<Object?> args,
  }) async {
    final db = await database;

    await db.delete(
      table,
      where: '$column = ?',
      whereArgs: args,
    );
  }

  @override
  Future<void> update({
    required Map<String, Object?> value,
    required String table,
    required String column,
    required List<Object?> args,
  }) async {
    final db = await database;
    await db.update(
      table,
      value,
      where: '$column = ?',
      whereArgs: args,
    );
  }

  @override
  Future<List<Map<String, Object?>>> insert({
    required String table,
    required Map<String, Object?> value,
    String? column,
    List<Object?>? args,
  }) async {
    final db = await database;
    await db.insert(table, value);

    return (column == null)
        ? await read(table: table)
        : await read(table: table, column: column, args: args);
  }

  @override
  Future<List<Map<String, Object?>>> searchMessage(
      {required List<Object> args}) async {
    final db = await database;
    List<Map<String, Object?>> dbResult = await db.rawQuery(
      '''
    SELECT *
    FROM ${MessageFields.messagesTableName}
    WHERE ${MessageFields.chatId} = ? AND ${MessageFields.text} LIKE ?
     ''',
      args,
    );
    return dbResult;
  }
}
