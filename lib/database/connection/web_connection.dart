import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

Future<DatabaseConnection> open() async {
  final result = await WasmDatabase.open(
    databaseName: 'drift_demo',
    sqlite3Uri: Uri.parse('/sqlite3.wasm'),
    driftWorkerUri: Uri.parse('/drift_worker.js'),
  );

  if (result.missingFeatures.isNotEmpty) {
    debugPrint(
      'Drift web: fitur browser berikut tidak tersedia, '
      'data mungkin tidak persisten: ${result.missingFeatures}',
    );
  }

  return result.resolvedExecutor;
}
