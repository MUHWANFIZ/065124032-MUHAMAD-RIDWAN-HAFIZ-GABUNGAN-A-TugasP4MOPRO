import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqfliteProdukHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    String path = join(await getDatabasesPath(), 'produk_db.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE produk (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_produk TEXT NOT NULL,
            harga INTEGER NOT NULL,
            stok INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // Create
  static Future<int> insertProduk(
    String namaProduk,
    int harga,
    int stok,
  ) async {
    final database = await db;
    return await database.insert('produk', {
      'nama_produk': namaProduk,
      'harga': harga,
      'stok': stok,
    });
  }

  // Read
  static Future<List<Map<String, dynamic>>> getAllProduk() async {
    final database = await db;
    return await database.query('produk', orderBy: 'id DESC');
  }

  // Update
  static Future<int> updateProduk(
    int id,
    String namaProduk,
    int harga,
    int stok,
  ) async {
    final database = await db;
    return await database.update(
      'produk',
      {'nama_produk': namaProduk, 'harga': harga, 'stok': stok},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete
  static Future<int> deleteProduk(int id) async {
    final database = await db;
    return await database.delete(
      'produk',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
