import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<DatabaseConnection> open() async {
  return DatabaseConnection(
    LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'drift_demo.sqlite'));
      return NativeDatabase.createInBackground(file);
    }),
  );
}
