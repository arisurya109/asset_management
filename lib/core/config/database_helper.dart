// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._private();

  static final DatabaseHelper instance = DatabaseHelper._private();

  static Database? _database;

  // Database
  static const String _databaseName = 'asset_management.db';
  static const int _databaseVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();

    String path = join(dir.path, _databaseName);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');

    await db.execute('''
    CREATE TABLE t_asset_non_id (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    type TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE t_asset_count (
    id INTEGER PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    count_code TEXT NOT NULL,
    status TEXT NOT NULL,
    count_date TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE t_asset_count_detail (
    count_id INTEGER NOT NULL,
    asset_id TEXT NOT NULL,
    serial_number TEXT,
    asset_name TEXT,
    location TEXT NOT NULL,
    box TEXT,
    status TEXT,
    condition TEXT,
    FOREIGN KEY (count_id) REFERENCES t_asset_count(id)
    )
    ''');

    await db.execute('''
    CREATE TABLE t_asset_preparations (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    store_name TEXT NOT NULL,
    store_code INT NOT NULL,
    store_initial TEXT NOT NULL,
    status TEXT NOT NULL,
    total_box INT,
    type TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE t_asset_preparation_details (
    asset_preparation_id INT NOT NULL,
    asset TEXT NOT NULL,
    quantity INT NOT NULL,
    type TEXT NOT NULL,
    location TEXT NOT NULL,
    box TEXT,
    PRIMARY KEY (asset_preparation_id, asset),
    FOREIGN KEY (asset_preparation_id) REFERENCES t_asset_preparations(id)
    )
    ''');
  }
}
