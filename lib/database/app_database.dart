import 'package:drift/drift.dart';

import 'connection/connection.dart';

part 'app_database.g.dart';

// Skema Tabel Drift
@DataClassName('ProdukItem')
class Produk extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaProduk => text()();
  IntColumn get harga => integer()();
  IntColumn get stok => integer()();
}

@DriftDatabase(tables: [Produk])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(DatabaseConnection.delayed(openConnection()));

  @override
  int get schemaVersion => 1;

  // Operasi CRUD Drift

  // Read
  Future<List<ProdukItem>> getAllProduk() => select(produk).get();

  // Create
  Future<int> insertProduk(ProdukCompanion entry) => into(produk).insert(entry);

  // Update
  Future<bool> updateProduk(ProdukItem entry) => update(produk).replace(entry);

  // Delete
  Future<int> deleteProduk(int id) =>
      (delete(produk)..where((tbl) => tbl.id.equals(id))).go();
}
