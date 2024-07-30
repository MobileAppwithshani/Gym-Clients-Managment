import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:local_db/Models/user_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'member.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE members(id INTEGER PRIMARY KEY, name TEXT, gender TEXT, joining TEXT, closing TEXT, phone INTEGER, age INTEGER, weight INTEGER, height INTEGER, fee INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insert(UserModel user) async {
    final db = await database;
    await db.insert('members', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(UserModel user) async {
    final db = await database;
    await db.update('members', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete('members', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<UserModel>> getMembers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('members');
    return List.generate(maps.length, (i) {
      return UserModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        gender: maps[i]['gender'],
        joining: maps[i]['joining'],
        closing: maps[i]['closing'],
        phone: maps[i]['phone'],
        age: maps[i]['age'],
        weight: maps[i]['weight'],
        height: maps[i]['height'],
        fee: maps[i]['fee'],
      );
    });
  }
}
