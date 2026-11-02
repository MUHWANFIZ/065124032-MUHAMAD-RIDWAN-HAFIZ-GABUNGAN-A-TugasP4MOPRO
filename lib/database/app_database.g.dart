// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProdukTable extends Produk with TableInfo<$ProdukTable, ProdukItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProdukTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaProdukMeta = const VerificationMeta(
    'namaProduk',
  );
  @override
  late final GeneratedColumn<String> namaProduk = GeneratedColumn<String>(
    'nama_produk',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hargaMeta = const VerificationMeta('harga');
  @override
  late final GeneratedColumn<int> harga = GeneratedColumn<int>(
    'harga',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stokMeta = const VerificationMeta('stok');
  @override
  late final GeneratedColumn<int> stok = GeneratedColumn<int>(
    'stok',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, namaProduk, harga, stok];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produk';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProdukItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_produk')) {
      context.handle(
        _namaProdukMeta,
        namaProduk.isAcceptableOrUnknown(data['nama_produk']!, _namaProdukMeta),
      );
    } else if (isInserting) {
      context.missing(_namaProdukMeta);
    }
    if (data.containsKey('harga')) {
      context.handle(
        _hargaMeta,
        harga.isAcceptableOrUnknown(data['harga']!, _hargaMeta),
      );
    } else if (isInserting) {
      context.missing(_hargaMeta);
    }
    if (data.containsKey('stok')) {
      context.handle(
        _stokMeta,
        stok.isAcceptableOrUnknown(data['stok']!, _stokMeta),
      );
    } else if (isInserting) {
      context.missing(_stokMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProdukItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProdukItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      namaProduk: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_produk'],
      )!,
      harga: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga'],
      )!,
      stok: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stok'],
      )!,
    );
  }

  @override
  $ProdukTable createAlias(String alias) {
    return $ProdukTable(attachedDatabase, alias);
  }
}

class ProdukItem extends DataClass implements Insertable<ProdukItem> {
  final int id;
  final String namaProduk;
  final int harga;
  final int stok;
  const ProdukItem({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.stok,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_produk'] = Variable<String>(namaProduk);
    map['harga'] = Variable<int>(harga);
    map['stok'] = Variable<int>(stok);
    return map;
  }

  ProdukCompanion toCompanion(bool nullToAbsent) {
    return ProdukCompanion(
      id: Value(id),
      namaProduk: Value(namaProduk),
      harga: Value(harga),
      stok: Value(stok),
    );
  }

  factory ProdukItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProdukItem(
      id: serializer.fromJson<int>(json['id']),
      namaProduk: serializer.fromJson<String>(json['namaProduk']),
      harga: serializer.fromJson<int>(json['harga']),
      stok: serializer.fromJson<int>(json['stok']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaProduk': serializer.toJson<String>(namaProduk),
      'harga': serializer.toJson<int>(harga),
      'stok': serializer.toJson<int>(stok),
    };
  }

  ProdukItem copyWith({int? id, String? namaProduk, int? harga, int? stok}) =>
      ProdukItem(
        id: id ?? this.id,
        namaProduk: namaProduk ?? this.namaProduk,
        harga: harga ?? this.harga,
        stok: stok ?? this.stok,
      );
  ProdukItem copyWithCompanion(ProdukCompanion data) {
    return ProdukItem(
      id: data.id.present ? data.id.value : this.id,
      namaProduk: data.namaProduk.present
          ? data.namaProduk.value
          : this.namaProduk,
      harga: data.harga.present ? data.harga.value : this.harga,
      stok: data.stok.present ? data.stok.value : this.stok,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProdukItem(')
          ..write('id: $id, ')
          ..write('namaProduk: $namaProduk, ')
          ..write('harga: $harga, ')
          ..write('stok: $stok')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, namaProduk, harga, stok);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProdukItem &&
          other.id == this.id &&
          other.namaProduk == this.namaProduk &&
          other.harga == this.harga &&
          other.stok == this.stok);
}

class ProdukCompanion extends UpdateCompanion<ProdukItem> {
  final Value<int> id;
  final Value<String> namaProduk;
  final Value<int> harga;
  final Value<int> stok;
  const ProdukCompanion({
    this.id = const Value.absent(),
    this.namaProduk = const Value.absent(),
    this.harga = const Value.absent(),
    this.stok = const Value.absent(),
  });
  ProdukCompanion.insert({
    this.id = const Value.absent(),
    required String namaProduk,
    required int harga,
    required int stok,
  }) : namaProduk = Value(namaProduk),
       harga = Value(harga),
       stok = Value(stok);
  static Insertable<ProdukItem> custom({
    Expression<int>? id,
    Expression<String>? namaProduk,
    Expression<int>? harga,
    Expression<int>? stok,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaProduk != null) 'nama_produk': namaProduk,
      if (harga != null) 'harga': harga,
      if (stok != null) 'stok': stok,
    });
  }

  ProdukCompanion copyWith({
    Value<int>? id,
    Value<String>? namaProduk,
    Value<int>? harga,
    Value<int>? stok,
  }) {
    return ProdukCompanion(
      id: id ?? this.id,
      namaProduk: namaProduk ?? this.namaProduk,
      harga: harga ?? this.harga,
      stok: stok ?? this.stok,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaProduk.present) {
      map['nama_produk'] = Variable<String>(namaProduk.value);
    }
    if (harga.present) {
      map['harga'] = Variable<int>(harga.value);
    }
    if (stok.present) {
      map['stok'] = Variable<int>(stok.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProdukCompanion(')
          ..write('id: $id, ')
          ..write('namaProduk: $namaProduk, ')
          ..write('harga: $harga, ')
          ..write('stok: $stok')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProdukTable produk = $ProdukTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [produk];
}

typedef $$ProdukTableCreateCompanionBuilder =
    ProdukCompanion Function({
      Value<int> id,
      required String namaProduk,
      required int harga,
      required int stok,
    });
typedef $$ProdukTableUpdateCompanionBuilder =
    ProdukCompanion Function({
      Value<int> id,
      Value<String> namaProduk,
      Value<int> harga,
      Value<int> stok,
    });

class $$ProdukTableFilterComposer
    extends Composer<_$AppDatabase, $ProdukTable> {
  $$ProdukTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaProduk => $composableBuilder(
    column: $table.namaProduk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stok => $composableBuilder(
    column: $table.stok,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProdukTableOrderingComposer
    extends Composer<_$AppDatabase, $ProdukTable> {
  $$ProdukTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaProduk => $composableBuilder(
    column: $table.namaProduk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stok => $composableBuilder(
    column: $table.stok,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProdukTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProdukTable> {
  $$ProdukTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaProduk => $composableBuilder(
    column: $table.namaProduk,
    builder: (column) => column,
  );

  GeneratedColumn<int> get harga =>
      $composableBuilder(column: $table.harga, builder: (column) => column);

  GeneratedColumn<int> get stok =>
      $composableBuilder(column: $table.stok, builder: (column) => column);
}

class $$ProdukTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProdukTable,
          ProdukItem,
          $$ProdukTableFilterComposer,
          $$ProdukTableOrderingComposer,
          $$ProdukTableAnnotationComposer,
          $$ProdukTableCreateCompanionBuilder,
          $$ProdukTableUpdateCompanionBuilder,
          (ProdukItem, BaseReferences<_$AppDatabase, $ProdukTable, ProdukItem>),
          ProdukItem,
          PrefetchHooks Function()
        > {
  $$ProdukTableTableManager(_$AppDatabase db, $ProdukTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProdukTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProdukTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProdukTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> namaProduk = const Value.absent(),
                Value<int> harga = const Value.absent(),
                Value<int> stok = const Value.absent(),
              }) => ProdukCompanion(
                id: id,
                namaProduk: namaProduk,
                harga: harga,
                stok: stok,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String namaProduk,
                required int harga,
                required int stok,
              }) => ProdukCompanion.insert(
                id: id,
                namaProduk: namaProduk,
                harga: harga,
                stok: stok,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProdukTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProdukTable,
      ProdukItem,
      $$ProdukTableFilterComposer,
      $$ProdukTableOrderingComposer,
      $$ProdukTableAnnotationComposer,
      $$ProdukTableCreateCompanionBuilder,
      $$ProdukTableUpdateCompanionBuilder,
      (ProdukItem, BaseReferences<_$AppDatabase, $ProdukTable, ProdukItem>),
      ProdukItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProdukTableTableManager get produk =>
      $$ProdukTableTableManager(_db, _db.produk);
}
