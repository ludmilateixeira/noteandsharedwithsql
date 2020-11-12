// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ItemDao _itemDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Produto` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nomeproduto` TEXT, `pessoa` TEXT, `preco` REAL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }
}

class _$ItemDao extends ItemDao {
  _$ItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _produtoInsertionAdapter = InsertionAdapter(
            database,
            'Produto',
            (Produto item) => <String, dynamic>{
                  'id': item.id,
                  'nomeproduto': item.nomeproduto,
                  'pessoa': item.pessoa,
                  'preco': item.preco
                }),
        _produtoUpdateAdapter = UpdateAdapter(
            database,
            'Produto',
            ['id'],
            (Produto item) => <String, dynamic>{
                  'id': item.id,
                  'nomeproduto': item.nomeproduto,
                  'pessoa': item.pessoa,
                  'preco': item.preco
                }),
        _produtoDeletionAdapter = DeletionAdapter(
            database,
            'Produto',
            ['id'],
            (Produto item) => <String, dynamic>{
                  'id': item.id,
                  'nomeproduto': item.nomeproduto,
                  'pessoa': item.pessoa,
                  'preco': item.preco
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Produto> _produtoInsertionAdapter;

  final UpdateAdapter<Produto> _produtoUpdateAdapter;

  final DeletionAdapter<Produto> _produtoDeletionAdapter;

  @override
  Future<List<Produto>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Produto',
        mapper: (Map<String, dynamic> row) => Produto(
            id: row['id'] as int,
            nomeproduto: row['nomeproduto'] as String,
            pessoa: row['pessoa'] as String,
            preco: row['preco'] as double));
  }

  @override
  Future<Produto> getItemById(int id) async {
    return _queryAdapter.query('SELECT * from Produto where id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Produto(
            id: row['id'] as int,
            nomeproduto: row['nomeproduto'] as String,
            pessoa: row['pessoa'] as String,
            preco: row['preco'] as double));
  }

  @override
  Future<int> insertItem(Produto p) {
    return _produtoInsertionAdapter.insertAndReturnId(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Produto p) {
    return _produtoUpdateAdapter.updateAndReturnChangedRows(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteItem(Produto p) {
    return _produtoDeletionAdapter.deleteAndReturnChangedRows(p);
  }
}
