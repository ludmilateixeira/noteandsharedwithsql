import 'package:noteandsharedwithsql/models/item.model.dart';
import 'package:noteandsharedwithsql/repositories/item.dao.dart';
import 'package:noteandsharedwithsql/repositories/item.database.dart';

class ItemRepository {
  static ItemRepository _instance;
  ItemRepository._();
  AppDatabase database;
  ItemDao itemDao;
  static Future<ItemRepository> getInstance() async {
    if (_instance != null) return _instance;
    _instance = ItemRepository._();
    await _instance.init();
    return _instance;
  }

  Future<void> init() async {
    database = await $FloorAppDatabase.databaseBuilder('items.db').build();
    itemDao = database.itemDao;
  }

  Future<List<Produto>> getAll() async {
    try {
      return await itemDao.getAll();
    } catch (e) {
      return List<Produto>();
    }
  }

  Future<bool> create(Produto p) async {
    try {
      await itemDao.insertItem(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(Produto p) async {
    try {
      await itemDao.updateItem(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      Produto p = await itemDao.getItemById(id);
      await itemDao.deleteItem(p);
      return true;
    } catch (e) {
      return false;
    }
  }
}
