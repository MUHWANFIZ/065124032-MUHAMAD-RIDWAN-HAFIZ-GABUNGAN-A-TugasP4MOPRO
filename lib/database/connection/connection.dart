import 'package:drift/drift.dart';

import 'native_connection.dart' if (dart.library.js_interop) 'web_connection.dart';

Future<DatabaseConnection> openConnection() => open();
