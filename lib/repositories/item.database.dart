import 'dart:async';
import 'package:noteandsharedwithsql/models/item.model.dart';
import 'package:noteandsharedwithsql/repositories/item.dao.dart';
import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
part 'item.database.g.dart'; // the generated code will be there

@Database(version: 1,entities: [Produto])
abstract class AppDatabase extends FloorDatabase{
  ItemDao get itemDao;
}
